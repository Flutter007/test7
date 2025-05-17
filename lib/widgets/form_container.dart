import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final Widget form;
  final void Function() onPressed;
  final String buttonText;
  const FormContainer({
    super.key,
    required this.form,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: form),
        SizedBox(height: 14),
        ElevatedButton(onPressed: onPressed, child: Text(buttonText)),
      ],
    );
  }
}
