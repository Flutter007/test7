import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test7/models/quote.dart';
import 'package:test7/provider/quotes_provider.dart';
import 'package:test7/widgets/quote_form/quote_form.dart';

import '../widgets/circular_progress.dart';
import '../widgets/custom_drop_down_menu.dart';
import '../widgets/form_container.dart';
import '../widgets/quote_form/quote_form_controllers.dart';

class EditQuoteScreen extends StatefulWidget {
  const EditQuoteScreen({super.key});

  @override
  State<EditQuoteScreen> createState() => _EditQuoteScreenState();
}

class _EditQuoteScreenState extends State<EditQuoteScreen> {
  late QuotesProvider quotesProvider;
  late String quoteId;
  late String categoryId;
  final controller = QuoteFormControllers();
  String? selectedType;
  final url =
      'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app';
  Quote? quote;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      quoteId = args['quoteId'];
      categoryId = args['categoryId'];
      quotesProvider = context.read<QuotesProvider>();
      quote = await quotesProvider.fetchQuote(quoteId);
      setQuote(quote);
    });
  }

  void setQuote(Quote? quote) {
    if (quote == null) return;
    setState(() {
      selectedType = quote.categoryId;
      controller.authorController.text = quote.author;
      controller.quoteController.text = quote.quote;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    selectedType = null;
    super.dispose();
  }

  void sendQuote() async {
    try {
      final quote = Quote(
        categoryId: selectedType!,
        author: controller.authorController.text,
        quote: controller.quoteController.text,
        createdAt: DateTime.now(),
        id: quoteId,
      );
      await quotesProvider.updateQuote(quote);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Quote updated successfully!')));
      }
      await quotesProvider.fetchListQuotes(url, categoryId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong! Try later!')),
        );
      }
    }
  }

  void updateQuote() async {
    if (controller.formKey.currentState!.validate()) {
      sendQuote();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quotesProvider = context.watch<QuotesProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Edit quote here!')),
      body:
          quotesProvider.isCreating
              ? CircularProgress()
              : FormContainer(
                form: QuoteForm(
                  controller: controller,
                  child: CustomDropDownMenu(
                    selectedType: selectedType,
                    onSelected: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                ),
                onPressed: updateQuote,
                buttonText: 'Update',
              ),
    );
  }
}
