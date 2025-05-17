import 'package:flutter/material.dart';
import '../models/category_of_quotes.dart';

class CustomDropDownMenu extends StatelessWidget {
  final String? selectedType;
  final Function(String?) onSelected;
  const CustomDropDownMenu({
    super.key,
    this.selectedType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 330,
      label: Text('Choose category:'),
      initialSelection: selectedType,
      onSelected: onSelected,
      dropdownMenuEntries:
          categories
              .where((c) => c.id != 'all-quotes')
              .map((t) => DropdownMenuEntry(value: t.id, label: t.meaning))
              .toList(),
    );
  }
}
