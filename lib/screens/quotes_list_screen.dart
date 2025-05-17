import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test7/widgets/quote_card.dart';

import '../app_routes.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      id = ModalRoute.of(context)!.settings.arguments as String;
      quotesProvider = context.read<QuotesProvider>();
      quotesProvider.fetchPosts(url, id);
    });
  }

  void goToQuoteForm(String id) {
    Navigator.of(context).pushNamed(AppRoutes.edit, arguments: id);
  }

  void showDeletedMessage() {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Quote deleted successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final quotesProvider = context.watch<QuotesProvider>();
    final quotes = quotesProvider.quotes;
    Widget body;
    if (quotesProvider.isFetching || quotesProvider.isDeleting) {
      body = Center(child: CircularProgressIndicator());
    } else if (quotes.isEmpty) {
      body = Center(child: Text('No quotes found!'));
    } else if (quotesProvider.isError) {
      body = Center(child: Text('Something went wrong! Try later!'));
    } else {
      body = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder:
                  (ctx, i) => QuoteCard(
                    quote: quotes[i],
                    onLongPress: () => goToQuoteForm(quotes[i].id!),
                    deleteQuote: () async {
                      await quotesProvider.deleteQuote(quotes[i].id!);
                      showDeletedMessage();
                      await quotesProvider.fetchPosts(url, id);
                    },
                  ),
              itemCount: quotes.length,
            ),
          ),
        ],
      );
    }
    return Scaffold(appBar: AppBar(title: Text(id.toUpperCase())), body: body);
  }
}
