import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:marinuata_app/data/providers.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/screens/landing_form_screen.dart';
import 'package:gap/gap.dart';

class LandingListScreen extends ConsumerStatefulWidget {
  const LandingListScreen({super.key});

  @override
  ConsumerState<LandingListScreen> createState() => _LandingListScreenState();
}

class _LandingListScreenState extends ConsumerState<LandingListScreen> {
  void _openForEdit(Landing landing) async {
    if (landing.isSynced) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registro já enviado! Apenas visualização.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LandingFormScreen(landingToEdit: landing),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Registros'),
        backgroundColor: const Color(0xFF00294D),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Landing>>(
        future: ref.read(isarServiceProvider).getAllLandings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final landings = snapshot.data ?? [];

          if (landings.isEmpty) {
            return const Center(
              child: Text('Nenhum registro encontrado.',
                  style: TextStyle(color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: landings.length,
            itemBuilder: (context, index) {
              final item = landings[index];
              final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(item.date);

              final statusColor = item.isSynced ? Colors.green : Colors.orange;
              final statusIcon = item.isSynced ? Icons.cloud_done : Icons.edit;

              // CONSTRUÇÃO DO TÍTULO DA UNIDADE PRODUTIVA
              final productiveUnitTitle = [
                item.fishermanName,
                item.boatName,
                item.community
              ].where((e) => e != null && e.trim().isNotEmpty).join(' - ');

              final displayTitle = productiveUnitTitle.isNotEmpty
                  ? productiveUnitTitle
                  : 'Unidade Não Identificada';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      color: statusColor.withOpacity(0.6),
                      width: item.isSynced ? 1 : 2),
                ),
                child: InkWell(
                  onTap: () => _openForEdit(item),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- CABEÇALHO (Unidade Produtiva em Destaque) ---
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: statusColor.withOpacity(0.1),
                              child: Icon(statusIcon,
                                  color: statusColor, size: 20),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TÍTULO: Unidade Produtiva Completa
                                  Text(
                                    displayTitle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16, // Destaque
                                        color: Color(0xFF00294D)),
                                  ),
                                  // DATA
                                  Text(
                                    dateStr,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),

                        const Divider(height: 20, thickness: 0.5),

                        // --- LISTA DE ESPÉCIES DETALHADA ---
                        const Text("Capturas:",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        const Gap(4),
                        ...item.catches.map((fish) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                          color: Colors.blueGrey,
                                          shape: BoxShape.circle)),
                                  const Gap(8),
                                  Expanded(
                                    child: Text(
                                      fish.speciesName ?? 'Desconhecido',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '${fish.quantity?.toStringAsFixed(1) ?? "0"} ${fish.unit ?? ""}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
