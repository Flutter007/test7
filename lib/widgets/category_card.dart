import 'package:flutter/material.dart';
import '../models/category_of_quotes.dart';

class CategoryCard extends StatelessWidget {
  final CategoryOfQuotes category;
  final void Function() onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.all(10),
                child: Text(textAlign: TextAlign.start, category.meaning),
              ),
              onTap: onTap,
              subtitle: Text('Tap to see quotes'),
            ),
          ),
        ],
      ),
    );
  }
}
