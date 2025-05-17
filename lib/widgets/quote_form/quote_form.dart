import 'package:flutter/material.dart';
import 'package:test7/widgets/quote_form/quote_form_controllers.dart';

import '../custom_text_form_field.dart';

class QuoteForm extends StatefulWidget {
  final QuoteFormControllers controller;
  final Widget child;
  const QuoteForm({super.key, required this.controller, required this.child});

  @override
  State<QuoteForm> createState() => _QuoteFormState();
}

class _QuoteFormState extends State<QuoteForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: widget.controller.authorController,
            labelText: 'Enter author name :',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter author name';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          CustomTextFormField(
            controller: widget.controller.quoteController,
            labelText: 'Enter quote :',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quote text';
              }
              return null;
            },
          ),
          SizedBox(height: 14),
          widget.child,
        ],
      ),
    );
  }
}
