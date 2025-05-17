import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/quotes_provider.dart';

class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({super.key});

  @override
  State<QuotesListScreen> createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  late String id;
  late QuotesProvider quotesProvider;
  final url =
      'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/quotes.json';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as String;
    quotesProvider = context.watch<QuotesProvider>();
    quotesProvider.fetchPosts(
      id == 'all-quotes' ? url : '$url?orderBy="categoryId"&equalTo="$id"',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quotes List')),
      body: Placeholder(),
    );
  }
}
