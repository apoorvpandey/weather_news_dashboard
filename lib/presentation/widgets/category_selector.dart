import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String current;
  final Function(String) onChanged;

  const CategorySelector({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['general', 'business', 'technology', 'sports'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories.map((cat) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ChoiceChip(
            label: Text(cat[0].toUpperCase() + cat.substring(1)),
            selected: current == cat,
            onSelected: (_) => onChanged(cat),
          ),
        );
      }).toList(),
    );
  }
}
