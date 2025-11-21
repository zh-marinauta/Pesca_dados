import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:marinuata_app/data/providers.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/screens/landing_form_screen.dart'; // Importante

class LandingListScreen extends ConsumerStatefulWidget {
  const LandingListScreen({super.key});

  @override
  ConsumerState<LandingListScreen> createState() => _LandingListScreenState();
}

class _LandingListScreenState extends ConsumerState<LandingListScreen> {
  // Função para navegar para edição
  void _openForEdit(Landing landing) async {
    // REGRA DE BLOQUEIO: Se já sincronizou, não abre.
    if (landing.isSynced) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Registro já enviado! Edição bloqueada para garantir integridade.'),
        backgroundColor: Colors.grey,
      ));
      return;
    }

    // Se não sincronizou, abre o formulário de edição
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LandingFormScreen(
          landingToEdit: landing, // Passa o objeto para edição
        ),
      ),
    );

    // Ao voltar, força a reconstrução da lista para mostrar as mudanças
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

              // Cálculo para preview
              double totalKg = 0;
              for (var fish in item.catches) {
                if (fish.unit == 'kg') totalKg += (fish.quantity ?? 0);
              }

              final dateStr = DateFormat('dd/MM HH:mm').format(item.date);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                // Cor da borda muda se puder editar
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      color: item.isSynced
                          ? Colors.green.withOpacity(0.5)
                          : Colors.orange,
                      width: item.isSynced ? 1 : 2),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor:
                        item.isSynced ? Colors.green[100] : Colors.orange[100],
                    child: Icon(
                      item.isSynced
                          ? Icons.cloud_done
                          : Icons.edit, // Ícone muda
                      color: item.isSynced ? Colors.green : Colors.orange[900],
                    ),
                  ),
                  title: Text(
                    item.boatName ?? 'Não Identificado',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$dateStr • ${item.fishermanName ?? ""}'),
                      Text(
                          '${item.catches.length} espécies • Total $totalKg kg'),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openForEdit(item), // <--- O CLIQUE MÁGICO
                ),
              );
            },
          );
        },
      ),
    );
  }
}
