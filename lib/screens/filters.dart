import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, bool>) {
      _glutenFree = args['gluten'] ?? _glutenFree;
      _lactoseFree = args['lactose'] ?? _lactoseFree;
      _vegetarian = args['vegetarian'] ?? _vegetarian;
      _vegan = args['vegan'] ?? _vegan;
    }
    _loaded = true;
  }

  void _saveAndClose() {
    Navigator.of(context).pop(<String, bool>{
      'gluten': _glutenFree,
      'lactose': _lactoseFree,
      'vegetarian': _vegetarian,
      'vegan': _vegan,
    });
  }

  Widget _buildSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(onPressed: _saveAndClose, icon: const Icon(Icons.save)),
        ],
      ),
      body: ListView(
        children: [
          _buildSwitch(
            title: 'Gluten‑free',
            subtitle: 'Only include gluten‑free meals',
            value: _glutenFree,
            onChanged: (v) => setState(() => _glutenFree = v),
          ),
          _buildSwitch(
            title: 'Lactose‑free',
            subtitle: 'Only include lactose‑free meals',
            value: _lactoseFree,
            onChanged: (v) => setState(() => _lactoseFree = v),
          ),
          _buildSwitch(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals',
            value: _vegetarian,
            onChanged: (v) => setState(() => _vegetarian = v),
          ),
          _buildSwitch(
            title: 'Vegan',
            subtitle: 'Only include vegan meals',
            value: _vegan,
            onChanged: (v) => setState(() => _vegan = v),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FilledButton.icon(
              onPressed: _saveAndClose,
              icon: const Icon(Icons.check),
              label: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
