import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/quote.dart';

final dateFormat = DateFormat('dd/MM/yyyy');

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final void Function() onLongPress;
  final void Function() deleteQuote;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onLongPress,
    required this.deleteQuote,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 10,
      child: InkWell(
        onLongPress: onLongPress,
        child: Column(
          children: [
            ListTile(
              title: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  textAlign: TextAlign.start,
                  "${quote.author} said ....",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              subtitle: Text(
                '"${quote.quote}"',
                style: theme.textTheme.titleMedium,
              ),
              trailing: IconButton(
                onPressed: deleteQuote,
                icon: Icon(Icons.delete, color: theme.colorScheme.error),
              ),
            ),
            Text(dateFormat.format(quote.createdAt)),
          ],
        ),
      ),
    );
  }
}
