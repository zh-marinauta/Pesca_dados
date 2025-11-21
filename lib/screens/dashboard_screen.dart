import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marinuata_app/data/providers.dart';
import 'package:marinuata_app/data/sync_service.dart';
import 'package:marinuata_app/screens/landing_form_screen.dart';
import 'package:marinuata_app/screens/landing_list_screen.dart';
import 'package:marinuata_app/screens/fleet_list_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // --- VARIÁVEIS ---
  final List<String> _landingPoints = [
    'Antonina - Praia dos Polacos',
    'Antonina - Ponta da Pita',
    'Antonina - Feiramar',
    'Antonina - Portinho',
    'Paranaguá - Mercado do Peixe',
    'Paranaguá - Vila Guarani',
    'Pontal do Paraná - Pontal do Sul',
  ];
  String? _selectedPoint;

  int _pendingCount = 0;
  int _monthTrips = 0;
  double _monthWeight = 0;
  double _monthDozen = 0;
  int _monthActiveUnits = 0;

  int _yearTrips = 0;
  double _yearWeight = 0;
  double _yearDozen = 0;
  int _yearActiveUnits = 0;

  bool _isLoading = true;
  bool _isSyncing = false;
  String _locationStatus = "Buscando GPS...";
  bool _gpsActive = false;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _getCurrentLocation();
  }

  Future<void> _loadInitialData() async {
    final metrics = await ref.read(isarServiceProvider).getDashboardMetrics();
    final lastPoint =
        await ref.read(isarServiceProvider).getLastUsedLandingPoint();

    if (mounted) {
      setState(() {
        _pendingCount = metrics['pending_sync'];

        // Mês
        _monthTrips = metrics['trips_month'];
        _monthWeight = metrics['weight_month'];
        _monthDozen = metrics['dozen_month'];
        _monthActiveUnits = metrics['units_month'] as int;

        // Ano
        _yearTrips = metrics['trips_year'];
        _yearWeight = metrics['weight_year'];
        _yearDozen = metrics['dozen_year'];
        _yearActiveUnits = metrics['units_year'] as int;

        if (lastPoint != null && _landingPoints.contains(lastPoint)) {
          _selectedPoint = lastPoint;
        } else {
          _selectedPoint = _landingPoints.first;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        if (mounted) {
          setState(() {
            _gpsActive = true;
            _locationStatus =
                "GPS: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
          });
        }
      } else {
        if (mounted) setState(() => _locationStatus = "Sem permissão GPS");
      }
    } catch (e) {
      if (mounted) setState(() => _locationStatus = "Erro GPS");
    }
  }

  Future<void> _runSync() async {
    setState(() => _isSyncing = true);
    try {
      final count = await SyncService(ref.read(isarServiceProvider))
          .syncPendingLandings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                count > 0 ? 'Sucesso! $count enviados.' : 'Tudo atualizado!'),
            backgroundColor: count > 0 ? Colors.green : Colors.black87));
      }
      await _loadInitialData();
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        user?.displayName ?? user?.email?.split('@')[0] ?? 'Monitor';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF00294D),
        foregroundColor: Colors.white,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Marinauta Monitor', style: TextStyle(fontSize: 16)),
          Text('Olá, $userName',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
        ]),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async => await FirebaseAuth.instance.signOut())
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadInitialData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LOCAL + GPS
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey.shade100)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("📍 Local de Monitoramento",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: _selectedPoint,
                        isExpanded: true,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down_circle,
                            color: Color(0xFF00294D)),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00294D)),
                        onChanged: (v) => setState(() => _selectedPoint = v),
                        items: _landingPoints
                            .map((v) =>
                                DropdownMenuItem(value: v, child: Text(v)))
                            .toList(),
                      ),
                      const Divider(height: 12),
                      Row(children: [
                        Icon(
                            _gpsActive
                                ? Icons.my_location
                                : Icons.location_disabled,
                            size: 14,
                            color: _gpsActive ? Colors.green : Colors.grey),
                        const Gap(6),
                        Text(_locationStatus,
                            style: TextStyle(
                                fontSize: 12,
                                color: _gpsActive
                                    ? Colors.green[800]
                                    : Colors.grey)),
                      ])
                    ]),
              ),
              const Gap(16),

              _buildSyncCard(),
              const Gap(20),

              // --- MÉTRICAS UNIFICADAS (MÊS EM CIMA / ANO EM BAIXO) ---
              Text('Resumo de Produção',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF00294D),
                      fontWeight: FontWeight.bold)),
              const Gap(10),

              // Linha 1: Desembarques e Kg
              Row(children: [
                Expanded(
                    child: _buildStatCard(
                        title: 'Desembarques',
                        monthVal: '$_monthTrips',
                        yearVal: '$_yearTrips',
                        icon: Icons.sailing,
                        color: const Color(0xFF005CA9))),
                const Gap(12),
                Expanded(
                    child: _buildStatCard(
                        title: 'Kg (Peso)',
                        monthVal: _monthWeight.toStringAsFixed(1),
                        yearVal: _yearWeight.toStringAsFixed(1),
                        icon: Icons.scale,
                        color: Colors.teal)),
              ]),
              const Gap(12),

              // Linha 2: Dúzias e Unidades
              Row(children: [
                Expanded(
                    child: _buildStatCard(
                        title: 'Dúzias',
                        monthVal: _monthDozen.toStringAsFixed(0),
                        yearVal: _yearDozen.toStringAsFixed(0),
                        icon: Icons.apps,
                        color: Colors.orange[800]!)),
                const Gap(12),
                Expanded(
                    child: _buildStatCard(
                        title: 'Unid. Ativas',
                        monthVal: '$_monthActiveUnits',
                        yearVal: '$_yearActiveUnits',
                        icon: Icons.person_pin_circle,
                        color: Colors.indigo)),
              ]),

              const Gap(30),

              // AÇÕES
              Text('Ações Rápidas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF00294D),
                      fontWeight: FontWeight.bold)),
              const Gap(10),

              _buildMenuButton(
                label: 'NOVA COLETA',
                icon: Icons.add_circle,
                color: const Color(0xFF00294D),
                isPrimary: true,
                onTap: () async {
                  if (_selectedPoint != null) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LandingFormScreen(
                                initialLandingPoint: _selectedPoint!)));
                    _loadInitialData();
                  }
                },
              ),
              const Gap(12),
              _buildMenuButton(
                label: 'Meus Registros',
                icon: Icons.list_alt,
                color: Colors.white,
                textColor: const Color(0xFF00294D),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LandingListScreen()));
                  _loadInitialData();
                },
              ),
              const Gap(12),
              _buildMenuButton(
                label: 'Pescadores e Barcos',
                icon: Icons.groups,
                color: Colors.white,
                textColor: const Color(0xFF00294D),
                onTap: () {
                  // NAVEGAÇÃO ATIVADA
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FleetListScreen()));
                },
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildSyncCard() {
    final hasPending = _pendingCount > 0;
    return Card(
      elevation: 2,
      color: hasPending ? Colors.orange[50] : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: hasPending ? Colors.orange : Colors.transparent,
              width: 1.5)),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Icon(hasPending ? Icons.cloud_upload : Icons.cloud_done,
                color: hasPending ? Colors.orange[800] : Colors.green[700],
                size: 36),
            const Gap(16),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(hasPending ? 'Envio Pendente' : 'Tudo Atualizado',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: hasPending
                              ? Colors.orange[900]
                              : Colors.green[900])),
                  Text(
                      hasPending
                          ? '$_pendingCount desembarques para enviar.'
                          : 'Dados seguros na nuvem.',
                      style: TextStyle(color: Colors.grey[800], fontSize: 13)),
                ])),
            if (hasPending)
              _isSyncing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : IconButton.filled(
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.orange),
                      icon: const Icon(Icons.sync, color: Colors.white),
                      onPressed: _runSync)
          ])),
    );
  }

  // --- NOVO CARD COMBINADO ---
  Widget _buildStatCard(
      {required String title,
      required String monthVal, // Valor Grande
      required String yearVal, // Valor Pequeno
      required IconData icon,
      required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Topo: Ícone e Título
        Row(children: [
          Icon(icon, color: color, size: 20),
          const Gap(8),
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis)),
        ]),
        const Gap(12),

        // Meio: Valor Mês (Grande)
        Text(monthVal,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const Text("no mês atual",
            style: TextStyle(fontSize: 10, color: Colors.grey)),

        const Gap(8),
        const Divider(height: 10),

        // Baixo: Valor Ano (Pequeno)
        Row(children: [
          const Text("Ano: ",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          Text(yearVal,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800])),
        ])
      ]),
    );
  }

  Widget _buildMenuButton(
      {required String label,
      required IconData icon,
      required Color color,
      Color textColor = Colors.white,
      bool isPrimary = false,
      required VoidCallback onTap}) {
    return Material(
        color: color,
        borderRadius: BorderRadius.circular(14),
        elevation: isPrimary ? 4 : 0,
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(children: [
                  Icon(icon, color: textColor, size: 28),
                  const Gap(16),
                  Text(label,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      color: textColor.withOpacity(0.7), size: 16)
                ]))));
  }
}
