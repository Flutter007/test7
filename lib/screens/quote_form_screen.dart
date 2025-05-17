import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test7/models/quote.dart';
import 'package:test7/provider/quotes_provider.dart';
import 'package:test7/widgets/circular_progress.dart';
import 'package:test7/widgets/custom_drop_down_menu.dart';
import 'package:test7/widgets/form_container.dart';
import 'package:test7/widgets/quote_form/quote_form.dart';

import '../widgets/quote_form/quote_form_controllers.dart';

class QuoteFormScreen extends StatefulWidget {
  const QuoteFormScreen({super.key});

  @override
  State<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends State<QuoteFormScreen> {
  final controller = QuoteFormControllers();
  String? selectedType;
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
      clearFields();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong! Try later!')),
        );
      }
    }
  }

  void clearFields() {
    controller.authorController.clear();
    controller.quoteController.clear();
    setState(() {
      selectedType = null;
    });
  }

  void createQuote() {
    if (controller.formKey.currentState!.validate() && selectedType != null) {
      sentQuote();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create new quote here!')),
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
                onPressed: createQuote,
                buttonText: 'Create',
              ),
    );
  }
}
