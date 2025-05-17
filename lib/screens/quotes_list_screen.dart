import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test7/widgets/circular_progress.dart';
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
  final baseUrl =
      'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      id = ModalRoute.of(context)!.settings.arguments as String;
      quotesProvider = context.read<QuotesProvider>();
      await quotesProvider.fetchListQuotes(baseUrl, id);
    });
  }

  void goToQuoteForm(String quoteId, String categoryId) {
    Navigator.of(context).pushNamed(
      AppRoutes.edit,
      arguments: {'quoteId': quoteId, 'categoryId': categoryId},
    );
  }

  void showDeletedMessage() {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Quote deleted successfully!')));
    }
  }

  void showError() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong! Try later!')),
      );
    }
  }

  void deleteQuote(String deleteId, String categoryId) async {
    try {
      await quotesProvider.deleteQuote(deleteId);
      showDeletedMessage();
      await quotesProvider.fetchListQuotes(baseUrl, categoryId);
    } catch (e) {
      showError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quotesProvider = context.watch<QuotesProvider>();
    final quotes = quotesProvider.quotes;
    Widget body;

    if (quotesProvider.isFetching || quotesProvider.isDeleting) {
      body = CircularProgress();
    } else if (quotesProvider.isError) {
      body = Center(child: Text('Something went wrong! Try later!'));
    } else if (quotes.isEmpty) {
      body = Center(child: Text('No quotes found!'));
    } else {
      body = Column(
        children: [
          Text('Long Press to Edit'),
          Expanded(
            child: SafeArea(
              child: ListView.builder(
                itemBuilder:
                    (ctx, i) => QuoteCard(
                      quote: quotes[i],
                      onLongPress: () => goToQuoteForm(quotes[i].id!, id),
                      deleteQuote: () => deleteQuote(quotes[i].id!, id),
                    ),
                itemCount: quotes.length,
              ),
            ),
          ),
        ],
      );
    }
    return Scaffold(appBar: AppBar(title: Text('Quotes List')), body: body);
  }
}
