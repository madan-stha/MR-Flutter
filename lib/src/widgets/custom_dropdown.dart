import 'package:flutter/material.dart';
import 'package:smc_flutter/src/constant/app_styles.dart';

class CustomDropdown extends StatefulWidget {
  final String selectedValue;
  final List<Map<String, String>> items;
  final String label;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      items: _buildDropdownItems(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value!;
          widget.onChanged(_selectedValue);
        });
      },
      decoration: InputDecoration(
        labelText: widget.label,
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    Set<String> uniqueValues = Set();

    for (var item in widget.items) {
      if (!uniqueValues.contains(item['value'])) {
        dropdownItems.add(
          DropdownMenuItem(
            value: item['key'],
            child: Text(item['value']!, style: AppStyles.text14PxRegular),
          ),
        );
        uniqueValues.add(item['value']!);
      }
    }

    return dropdownItems;
  }
}
