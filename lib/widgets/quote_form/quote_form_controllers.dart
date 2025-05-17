import 'package:flutter/cupertino.dart';

class QuoteFormControllers {
  final formKey = GlobalKey<FormState>();
  final authorController = TextEditingController();
  final quoteController = TextEditingController();

  void dispose() {
    authorController.dispose();
    quoteController.dispose();
  }
}
