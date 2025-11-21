import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:marinuata_app/data/providers.dart';
import 'package:marinuata_app/data/reference_models.dart';

class FleetListScreen extends ConsumerStatefulWidget {
  const FleetListScreen({super.key});

  @override
  ConsumerState<FleetListScreen> createState() => _FleetListScreenState();
}

class _FleetListScreenState extends ConsumerState<FleetListScreen> {
  final _searchController = TextEditingController();
  List<ProductiveUnit> _units = [];
  List<ProductiveUnit> _filteredUnits = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFleet();
  }

  Future<void> _loadFleet() async {
    final isarService = ref.read(isarServiceProvider);
    // Busca a lista completa (em um app real com milhares, faríamos paginação)
    // Aqui usamos uma busca vazia para trazer tudo que o searchProductiveUnit permitir
    final allUnits = await isarService.searchProductiveUnit("");

    if (mounted) {
      setState(() {
        _units = allUnits;
        _filteredUnits = allUnits;
        _isLoading = false;
      });
    }
  }

  void _filterFleet(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUnits = _units;
      } else {
        _filteredUnits = _units
            .where(
                (u) => u.searchKey.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pescadores e Barcos'),
        backgroundColor: const Color(0xFF00294D),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // --- BARRA DE BUSCA ---
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF00294D),
            child: TextField(
              controller: _searchController,
              onChanged: _filterFleet,
              decoration: InputDecoration(
                hintText: 'Buscar por nome, barco...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterFleet('');
                        })
                    : null,
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),

          // --- LISTA ---
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredUnits.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.sailing_outlined,
                                size: 64, color: Colors.grey),
                            Gap(16),
                            Text('Nenhuma unidade encontrada.',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: _filteredUnits.length,
                        separatorBuilder: (ctx, i) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final unit = _filteredUnits[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[50],
                              child: const Icon(Icons.person,
                                  color: Color(0xFF00294D)),
                            ),
                            title: Text(
                              '${unit.fishermanName ?? "Sem nome"}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '⛵ ${unit.boatName ?? "-"}  •  📍 ${unit.community ?? "-"}'),
                                Text(
                                  '${unit.category ?? ""} / ${unit.boatType ?? ""}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Futuramente: Abrir para editar typos
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Edição de cadastro em breve')),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
