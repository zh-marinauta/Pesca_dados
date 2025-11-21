import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:isar/isar.dart'; // Importante para Isar.autoIncrement
import 'package:uuid/uuid.dart';
import 'package:marinuata_app/data/providers.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/data/reference_models.dart';

class LandingFormScreen extends ConsumerStatefulWidget {
  final String initialLandingPoint;
  final Landing? landingToEdit; // <--- OBJETO OPCIONAL PARA EDIÇÃO

  const LandingFormScreen({
    super.key,
    this.initialLandingPoint = '',
    this.landingToEdit, // <--- Recebe aqui
  });

  @override
  ConsumerState<LandingFormScreen> createState() => _LandingFormScreenState();
}

class _LandingFormScreenState extends ConsumerState<LandingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _categoriesList = [
    'Pesca Estuarina',
    'Pesca de Mar aberto',
    'Revendedores',
    'Pesca Esportiva'
  ];
  final List<String> _boatTypesList = [
    'Canoa',
    'Bote',
    'Bateira',
    'Lancha',
    'Baleeira',
    'Desembarcado'
  ];

  final _fishermanController = TextEditingController();
  final _boatController = TextEditingController();
  final _communityController = TextEditingController();

  String? _selectedCategory;
  String? _selectedBoatType;

  List<Catch> _catches = [];
  String? _productionSource = 'Própria';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // --- LÓGICA DE CARREGAMENTO PARA EDIÇÃO ---
    if (widget.landingToEdit != null) {
      final item = widget.landingToEdit!;

      // 1. Preenche Cabeçalho
      _fishermanController.text = item.fishermanName ?? '';
      _boatController.text = item.boatName ?? '';
      _communityController.text = item.community ?? '';

      // Valida se os dropdowns existem na lista (para não quebrar a UI)
      if (item.category != null && _categoriesList.contains(item.category)) {
        _selectedCategory = item.category;
      }
      if (item.boatType != null && _boatTypesList.contains(item.boatType)) {
        _selectedBoatType = item.boatType;
      }

      // 2. Preenche Peixes (Cria uma cópia para não editar a referência direta antes de salvar)
      _catches = List.from(item.catches);

      // 3. Preenche Rodapé
      if (item.productionSource != null) {
        _productionSource = item.productionSource;
      }
    }
  }

  void _addCatch() {
    setState(() {
      _catches.add(Catch()
        ..unit = 'kg'
        ..processingType = 'Bruto');
    });
  }

  void _removeCatch(int index) => setState(() => _catches.removeAt(index));

  void _fillHeader(ProductiveUnit unit) {
    setState(() {
      _fishermanController.text = unit.fishermanName ?? '';
      _boatController.text = unit.boatName ?? '';
      _communityController.text = unit.community ?? '';
      if (unit.category != null && _categoriesList.contains(unit.category))
        _selectedCategory = unit.category;
      if (unit.boatType != null && _boatTypesList.contains(unit.boatType))
        _selectedBoatType = unit.boatType;
    });
  }

  Future<void> _saveLanding() async {
    if (_catches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Adicione pelo menos uma espécie/peixe.')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final fisherman = _fishermanController.text.trim().isEmpty
          ? 'Pescador Não Identificado'
          : _fishermanController.text.trim();
      final boat = _boatController.text.trim().isEmpty
          ? 'Barco Não Identificado'
          : _boatController.text.trim();
      final community = _communityController.text.trim().isEmpty
          ? 'Comunidade Não Inf.'
          : _communityController.text.trim();

      final newLanding = Landing()
        // --- SEGREDO DA EDIÇÃO ---
        // Se tiver ID (edição), mantém. Se não, Isar.autoIncrement (novo).
        ..id = widget.landingToEdit?.id ?? Isar.autoIncrement
        // Mantém o UUID original se for edição
        ..uuid = widget.landingToEdit?.uuid ?? const Uuid().v4()

        // Mantém a data original se for edição, ou usa agora se for novo
        ..date = widget.landingToEdit?.date ?? DateTime.now()
        ..isSynced =
            false // Ao editar, sempre volta a ser "Não Sincronizado" (pendente)
        ..landingPoint =
            widget.landingToEdit?.landingPoint ?? widget.initialLandingPoint
        ..fishermanName = fisherman
        ..boatName = boat
        ..community = community
        ..category = _selectedCategory
        ..boatType = _selectedBoatType
        ..catches = _catches
        ..productionSource = _productionSource;

      await ref.read(isarServiceProvider).saveLandingWithLearning(newLanding);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro salvo com sucesso! 💾')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determina o título baseado se é edição ou novo
    final isEditing = widget.landingToEdit != null;

    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? 'Editar Coleta' : 'Nova Coleta'),
          backgroundColor: const Color(0xFF00294D),
          foregroundColor: Colors.white),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Só mostra a busca se for NOVO registro (na edição não faz sentido buscar outro)
            if (!isEditing) ...[
              _buildSearchBox(),
              const Gap(20),
            ],

            _buildSectionHeader('1. Unidade Produtiva'),
            _buildTextField(
                controller: _fishermanController,
                label: 'Nome Pescador',
                icon: Icons.person),
            const Gap(10),
            _buildTextField(
                controller: _boatController,
                label: 'Nome Barco',
                icon: Icons.sailing),
            const Gap(10),
            _buildTextField(
                controller: _communityController,
                label: 'Comunidade',
                icon: Icons.map),
            const Gap(10),
            Row(children: [
              Expanded(
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                          isDense: true),
                      value: _selectedCategory,
                      isExpanded: true,
                      items: _categoriesList
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedCategory = v))),
              const Gap(10),
              Expanded(
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: 'Tipo Emb.',
                          border: OutlineInputBorder(),
                          isDense: true),
                      value: _selectedBoatType,
                      isExpanded: true,
                      items: _boatTypesList
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedBoatType = v))),
            ]),

            const Gap(20),
            const Divider(thickness: 2),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildSectionHeader('2. Capturas'),
              ElevatedButton.icon(
                  onPressed: _addCatch,
                  icon: const Icon(Icons.add),
                  label: const Text("Peixe"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white))
            ]),
            if (_catches.isEmpty)
              const Center(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Nenhum peixe adicionado.",
                          style: TextStyle(color: Colors.grey)))),
            ..._catches
                .asMap()
                .entries
                .map((e) => _buildCatchCard(e.key, e.value)),

            const Gap(30),
            DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Origem da Produção',
                    border: OutlineInputBorder()),
                value: _productionSource,
                items: ['Própria', 'Terceiros', 'Ambos']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => _productionSource = v),
            const Gap(20),
            SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveLanding,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00294D),
                        foregroundColor: Colors.white),
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(isEditing ? 'ATUALIZAR DADOS' : 'SALVAR TUDO'))),
            const Gap(40),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES (IGUAIS AO ANTERIOR) ---
  Widget _customOptionsViewBuilder<T extends Object>(
      BuildContext context,
      AutocompleteOnSelected<T> onSelected,
      Iterable<T> options,
      String Function(T) displayStringForOption) {
    return Align(
        alignment: Alignment.topLeft,
        child: Material(
            elevation: 8.0,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8))),
            child: SizedBox(
                height: 300.0,
                width: 280.0,
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    separatorBuilder: (ctx, i) => const Divider(height: 1),
                    itemBuilder: (BuildContext context, int index) {
                      final T option = options.elementAt(index);
                      return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          title: Text(displayStringForOption(option),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                          onTap: () => onSelected(option));
                    }))));
  }

  Widget _buildSearchBox() {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("🔍 Buscar no Histórico",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF00294D))),
          const Gap(5),
          Autocomplete<ProductiveUnit>(
              displayStringForOption: (option) => option.searchKey,
              optionsBuilder: (textValue) async {
                if (textValue.text.isEmpty)
                  return const Iterable<ProductiveUnit>.empty();
                return await ref
                    .read(isarServiceProvider)
                    .searchProductiveUnit(textValue.text);
              },
              onSelected: (selection) {
                _fillHeader(selection);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Preenchido!"),
                    duration: Duration(milliseconds: 500)));
              },
              optionsViewBuilder: (context, onSelected, options) =>
                  _customOptionsViewBuilder(
                      context, onSelected, options, (opt) => opt.searchKey),
              fieldViewBuilder: (ctx, ctrl, focus, sub) => TextField(
                  controller: ctrl,
                  focusNode: focus,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      hintText: "Digite nome, barco...",
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(Icons.search, color: Colors.grey))))
        ]));
  }

  Widget _buildCatchCard(int index, Catch fish) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Espécie #${index + 1}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () => _removeCatch(index))
              ]),
              Row(children: [
                Expanded(
                    flex: 2,
                    child: Autocomplete<String>(
                        optionsBuilder: (v) async => await ref
                            .read(isarServiceProvider)
                            .searchSpecies(v.text),
                        onSelected: (v) => fish.speciesName = v,
                        optionsViewBuilder: (context, onSelected, options) =>
                            _customOptionsViewBuilder(
                                context, onSelected, options, (opt) => opt),
                        fieldViewBuilder: (ctx, ctrl, focus, sub) {
                          if (fish.speciesName != null && ctrl.text.isEmpty)
                            ctrl.text = fish.speciesName!;
                          return TextFormField(
                              controller: ctrl,
                              focusNode: focus,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  labelText: "Espécie",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(10)),
                              onChanged: (v) => fish.speciesName = v);
                        })),
                const Gap(5),
                Expanded(
                    child: Autocomplete<String>(
                        optionsBuilder: (v) async => await ref
                            .read(isarServiceProvider)
                            .searchFishingGear(v.text),
                        onSelected: (v) => fish.fishingGear = v,
                        optionsViewBuilder: (context, onSelected, options) =>
                            _customOptionsViewBuilder(
                                context, onSelected, options, (opt) => opt),
                        fieldViewBuilder: (ctx, ctrl, focus, sub) {
                          if (fish.fishingGear != null && ctrl.text.isEmpty)
                            ctrl.text = fish.fishingGear!;
                          return TextFormField(
                              controller: ctrl,
                              focusNode: focus,
                              decoration: const InputDecoration(
                                  labelText: "Arte",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(10)),
                              onChanged: (v) => fish.fishingGear = v);
                        }))
              ]),
              const Gap(8),
              Row(children: [
                Expanded(
                    child: _input(
                        label: "Qtd",
                        isNum: true,
                        onChanged: (v) => fish.quantity = double.tryParse(v))),
                const Gap(5),
                Expanded(
                    child: DropdownButtonFormField(
                        value: fish.unit,
                        items: ['kg', 'dz', 'caixa', 'unid']
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e,
                                    style: const TextStyle(fontSize: 12))))
                            .toList(),
                        onChanged: (v) => fish.unit = v,
                        decoration: const InputDecoration(
                            labelText: "Unid",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(8)))),
                const Gap(5),
                Expanded(
                    child: _input(
                        label: "R\$",
                        isNum: true,
                        onChanged: (v) => fish.price = double.tryParse(v)))
              ]),
              const Gap(8),
              Row(children: [
                Expanded(
                    child: _input(
                        label: "Pesqueiro",
                        onChanged: (v) => fish.fishingGround = v)),
                const Gap(5),
                Expanded(
                    child: DropdownButtonFormField(
                        value: fish.processingType,
                        items: ['Bruto', 'Limpo', 'Filetado']
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e,
                                    style: const TextStyle(fontSize: 12))))
                            .toList(),
                        onChanged: (v) => fish.processingType = v,
                        decoration: const InputDecoration(
                            labelText: "Tipo",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(8))))
              ])
            ])));
  }

  Widget _buildSectionHeader(String title) => Text(title,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00294D)));
  Widget _input(
          {required String label,
          required Function(String) onChanged,
          bool isNum = false}) =>
      TextFormField(
          decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(10)),
          keyboardType: isNum ? TextInputType.number : TextInputType.text,
          onChanged: onChanged);
  Widget _buildTextField(
          {required TextEditingController controller,
          required String label,
          IconData? icon}) =>
      TextFormField(
          controller: controller,
          decoration: InputDecoration(
              labelText: label,
              prefixIcon: icon != null ? Icon(icon) : null,
              border: const OutlineInputBorder()));
}
