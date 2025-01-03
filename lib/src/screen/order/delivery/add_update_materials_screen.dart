import 'package:flutter/material.dart';

import '../../../src.dart';

class AddUpdateMaterialsScreen extends StatefulWidget {
  final DeliveryDetailModel data;
  const AddUpdateMaterialsScreen({super.key, required this.data});

  @override
  State<AddUpdateMaterialsScreen> createState() =>
      _AddUpdateMaterialsScreenState();
}

class _AddUpdateMaterialsScreenState extends State<AddUpdateMaterialsScreen> {
  late List<Map<String, dynamic>> materials;

  @override
  void initState() {
    super.initState();
    materials = (widget.data.mapToMaterials());
  }

  void addMaterial() {
    setState(() {
      materials.add({'id': 1, 'name': 'Select Material', 'weight': 0.0});
    });
  }

  void removeMaterial(int index) {
    setState(() {
      materials.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Materialsss ${materials}');
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Add & Edit Materials',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.data.items.length,
              itemBuilder: (context, index) {
                return MaterialRow(
                  material: materials[index]['name'],
                  weight: materials[index]['weight'],
                  onRemove: () => removeMaterial(index),
                  onMaterialChange: (newValue) {
                    setState(() {
                      materials[index]['name'] = newValue;
                    });
                  },
                  onWeightChange: (newValue) {
                    setState(() {
                      materials[index]['weight'] = double.tryParse(newValue) ??
                          materials[index]['weight'];
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: addMaterial,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.kPrimaryColor,
                side: const BorderSide(color: AppColors.kPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Add Materials'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Save Changes logic here
                print(materials);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialRow extends StatelessWidget {
  final String material;
  final double weight;
  final VoidCallback onRemove;
  final ValueChanged<String> onMaterialChange;
  final ValueChanged<String> onWeightChange;

  MaterialRow({
    required this.material,
    required this.weight,
    required this.onRemove,
    required this.onMaterialChange,
    required this.onWeightChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: material,
              items: ['steel', 'copper', 'Select Material']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => onMaterialChange(value ?? material),
              decoration: const InputDecoration(
                labelText: 'Material',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              initialValue: weight.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => onWeightChange(value),
              decoration: const InputDecoration(
                labelText: 'Weight',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.kPrimaryColor)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.kPrimaryColor),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
