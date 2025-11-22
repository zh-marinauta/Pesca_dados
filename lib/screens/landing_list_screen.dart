import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:marinuata_app/data/providers.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/screens/landing_form_screen.dart';

class LandingListScreen extends ConsumerStatefulWidget {
  const LandingListScreen({super.key});

  @override
  ConsumerState<LandingListScreen> createState() => _LandingListScreenState();
}

class _LandingListScreenState extends ConsumerState<LandingListScreen> {
  // Formatação
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  final NumberFormat _numFormat = NumberFormat('###,##0.0', 'pt_BR');

  // --- ESTADO DA SELEÇÃO ---
  bool _isSelectionMode = false;
  final Set<int> _selectedIds = {};

  // Alterna seleção (BLINDADO: Só seleciona se não estiver sincronizado)
  void _toggleSelection(Landing landing) {
    if (landing.isSynced) return; // Bloqueia seleção de itens sincronizados

    setState(() {
      if (_selectedIds.contains(landing.id)) {
        _selectedIds.remove(landing.id);
        if (_selectedIds.isEmpty) _isSelectionMode = false;
      } else {
        _selectedIds.add(landing.id);
      }
    });
  }

  // Inicia seleção (BLINDADO)
  void _startSelection(Landing landing) {
    if (landing.isSynced) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Itens sincronizados não podem ser apagados.'),
        duration: Duration(seconds: 1),
      ));
      return;
    }

    setState(() {
      _isSelectionMode = true;
      _selectedIds.add(landing.id);
    });
  }

  // Selecionar Tudo (INTELIGENTE: Pega apenas os não sincronizados)
  void _toggleSelectAll(List<Landing> allItems) {
    // Filtra apenas os que podem ser deletados
    final deletableItems = allItems.where((e) => !e.isSynced).toList();

    setState(() {
      if (_selectedIds.length == deletableItems.length) {
        _selectedIds.clear();
        _isSelectionMode = false;
      } else {
        _selectedIds.clear();
        _selectedIds.addAll(deletableItems.map((e) => e.id));
        _isSelectionMode = true;
      }
    });
  }

  // Ação de Deletar
  Future<void> _deleteSelected() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
            'Deseja apagar ${_selectedIds.length} registro(s) pendentes?\nEssa ação não pode ser desfeita.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('APAGAR')),
        ],
      ),
    );

    if (shouldDelete == true) {
      await ref.read(isarServiceProvider).deleteLandings(_selectedIds.toList());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${_selectedIds.length} registros apagados.')));
        setState(() {
          _selectedIds.clear();
          _isSelectionMode = false;
        });
      }
    }
  }

  void _openForEdit(Landing landing) async {
    // Se estiver em modo seleção, apenas alterna (se permitido)
    if (_isSelectionMode) {
      _toggleSelection(landing);
      return;
    }

    if (landing.isSynced) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🔒 Registro já enviado! Edição bloqueada.'),
          backgroundColor: Colors.green[800],
          behavior: SnackBarBehavior.floating,
        ),
      );
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
    return FutureBuilder<List<Landing>>(
      future: ref.read(isarServiceProvider).getAllLandings(),
      builder: (context, snapshot) {
        final landings = snapshot.data ?? [];
        // Conta quantos itens são realmente deletáveis para lógica do Select All
        final deletableCount = landings.where((e) => !e.isSynced).length;
        final bool isAllDeletableSelected =
            deletableCount > 0 && _selectedIds.length == deletableCount;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor:
                _isSelectionMode ? Colors.grey[800] : const Color(0xFF00294D),
            foregroundColor: Colors.white,
            title: _isSelectionMode
                ? Text('${_selectedIds.length} selecionado(s)',
                    style: const TextStyle(fontSize: 18))
                : const Text('Meus Registros'),
            leading: _isSelectionMode
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _selectedIds.clear();
                      _isSelectionMode = false;
                    }),
                  )
                : null,
            actions: [
              if (_isSelectionMode) ...[
                IconButton(
                  icon: Icon(isAllDeletableSelected
                      ? Icons.deselect
                      : Icons.select_all),
                  tooltip: isAllDeletableSelected
                      ? 'Deselecionar tudo'
                      : 'Selecionar pendentes',
                  onPressed: () => _toggleSelectAll(landings),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: _selectedIds.isEmpty ? null : _deleteSelected,
                ),
              ]
            ],
          ),
          body: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : landings.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_outlined,
                              size: 80, color: Colors.grey[300]),
                          const Gap(16),
                          Text('Nenhuma coleta registrada.',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      itemCount: landings.length,
                      itemBuilder: (context, index) {
                        final item = landings[index];
                        final isSelected = _selectedIds.contains(item.id);
                        return _buildLandingCard(item, isSelected);
                      },
                    ),
        );
      },
    );
  }

  Widget _buildLandingCard(Landing item, bool isSelected) {
    // 1. Título Concatenado (Corrigido com Comunidade)
    final String productiveUnitTitle = [
      item.fishermanName,
      item.boatName,
      item.community, // Comunidade
      item.category,
      item.boatType
    ].where((s) => s != null && s.trim().isNotEmpty).join(' - ');

    final String displayTitle = productiveUnitTitle.isEmpty
        ? 'Unidade Não Identificada'
        : productiveUnitTitle;

    // Cálculos
    double totalKg = 0;
    double totalUnid = 0;
    for (var fish in item.catches) {
      final unit = fish.unit?.toLowerCase() ?? '';
      final qtd = fish.quantity ?? 0;
      if (unit == 'kg')
        totalKg += qtd;
      else
        totalUnid += qtd;
    }

    final isSynced = item.isSynced;
    final statusColor = isSynced ? Colors.green[700]! : Colors.orange[800]!;

    // Se estiver sincronizado, o fundo fica levemente "bloqueado" no modo seleção
    final bool isLocked = _isSelectionMode && isSynced;

    return Card(
      elevation: isSelected ? 4 : 2,
      color: isSelected
          ? Colors.blue[50]
          : (isLocked ? Colors.grey[100] : Colors.white),
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? const BorderSide(color: Color(0xFF00294D), width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _openForEdit(item),
        onLongPress: () => _startSelection(item),
        child: Container(
          decoration: BoxDecoration(
            border: isSelected
                ? null
                : Border(left: BorderSide(color: statusColor, width: 5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // --- ÁREA DE SELEÇÃO ---
                if (_isSelectionMode)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: isSynced
                        // Se Sincronizado: Mostra Cadeado (Bloqueado)
                        ? const Icon(Icons.lock_outline,
                            color: Colors.grey, size: 24)
                        // Se Pendente: Mostra Checkbox
                        : Checkbox(
                            value: isSelected,
                            activeColor: const Color(0xFF00294D),
                            onChanged: (v) => _toggleSelection(item),
                          ),
                  ),

                // --- CONTEÚDO ---
                Expanded(
                  child: Opacity(
                    // Deixa o item levemente transparente se estiver bloqueado no modo seleção
                    opacity: isLocked ? 0.5 : 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Título em Negrito
                                  Text(
                                    displayTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: const Color(0xFF00294D)
                                          .withOpacity(isSelected ? 1 : 0.8),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Gap(4),
                                  // Data
                                  Row(children: [
                                    const Icon(Icons.access_time,
                                        size: 12, color: Colors.grey),
                                    const Gap(4),
                                    Text(_dateFormat.format(item.date),
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 13)),
                                  ]),
                                ],
                              ),
                            ),
                            // Se NÃO estiver selecionando, mostra o ícone de status na direita
                            if (!_isSelectionMode) ...[
                              const Gap(8),
                              _buildStatusIcon(isSynced, statusColor),
                            ]
                          ],
                        ),
                        const Divider(height: 24),
                        // Rodapé
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[50],
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text('${item.catches.length} espécies',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueGrey[700],
                                      fontWeight: FontWeight.bold)),
                            ),
                            const Spacer(),
                            if (totalKg > 0)
                              Text('${_numFormat.format(totalKg)} kg',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            if (totalKg > 0 && totalUnid > 0) const Gap(12),
                            if (totalUnid > 0)
                              Text('${_numFormat.format(totalUnid)} un/dz',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(bool isSynced, Color color) {
    return Icon(
      isSynced ? Icons.cloud_done : Icons.cloud_upload,
      size: 20,
      color: color,
    );
  }
}
