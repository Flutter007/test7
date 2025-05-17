import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/quote.dart';

final dateFormat = DateFormat('dd/MM/yyyy');

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final void Function() onTap;

  const QuoteCard({super.key, required this.quote, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Expanded(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.all(10),
                child: Text(textAlign: TextAlign.start, quote.author),
              ),
              onTap: onTap,
              subtitle: Text(quote.quote),
            ),
          ),
          Text('Created at: ${dateFormat.format(quote.createdAt)} '),
        ],
      ),
    );
  }
}
