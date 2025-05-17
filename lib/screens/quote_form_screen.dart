import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test7/models/category_of_quotes.dart';
import 'package:test7/models/quote.dart';
import 'package:test7/provider/quotes_provider.dart';
import 'package:test7/widgets/quote_form/quote_form.dart';

import '../widgets/quote_form/quote_form_controllers.dart';

class QuoteFormScreen extends StatefulWidget {
  const QuoteFormScreen({super.key});

  @override
  State<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends State<QuoteFormScreen> {
  final controller = QuoteFormControllers();
  String? selectedType = 'all-quotes';
  late QuotesProvider quotesProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    quotesProvider = context.watch<QuotesProvider>();
  }

  void sentQuote() async {
    try {
      final quote = Quote(
        categoryId: selectedType!,
        author: controller.authorController.text,
        quote: controller.quoteController.text,
        createdAt: DateTime.now(),
      );
      await quotesProvider.createQuote(quote);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Quote created successfully!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong! Try later!')),
        );
      }
    }
  }

  void createQuote() {
    if (controller.formKey.currentState!.validate()) {
      sentQuote();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create new quote here!')),
      body:
          quotesProvider.isCreating
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Center(
                    child: QuoteForm(
                      controller: controller,
                      child: DropdownMenu(
                        width: 330,
                        label: Text('Choose category:'),
                        initialSelection: selectedType,
                        onSelected:
                            (value) => setState(() {
                              selectedType = value;
                            }),
                        dropdownMenuEntries:
                            categories
                                .map(
                                  (t) => DropdownMenuEntry(
                                    value: t.id,
                                    label: t.meaning,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  ElevatedButton(onPressed: createQuote, child: Text('Create')),
                ],
              ),
    );
  }
}
