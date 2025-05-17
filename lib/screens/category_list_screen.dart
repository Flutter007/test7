import 'package:flutter/material.dart';
import 'package:test7/models/category_of_quotes.dart';
import 'package:test7/widgets/category_card.dart';
import '../app_routes.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  void goToQuotesList(String id) {
    Navigator.of(context).pushNamed(AppRoutes.quoteList, arguments: id);
  }

  void goToQuoteForm() {
    Navigator.of(context).pushNamed(AppRoutes.create);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App for your Quotes!'),
        actions: [
          IconButton(onPressed: goToQuoteForm, icon: Icon(Icons.add, size: 30)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder:
                    (ctx, index) => CategoryCard(
                      category: categories[index],
                      onTap: () => goToQuotesList(categories[index].id),
                    ),
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
