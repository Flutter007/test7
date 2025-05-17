import 'package:flutter/material.dart';
import 'package:test7/models/quote.dart';
import '../helpers/request.dart';

class QuotesProvider extends ChangeNotifier {
  List<Quote> _quotes = [];
  bool _isFetching = false;
  bool _isError = false;
  bool _isCreating = false;
  List<Quote> get quotes => _quotes;
  bool get isFetching => _isFetching;
  bool get isError => _isError;
  bool get isCreating => _isCreating;

  Future<void> fetchPosts(String url) async {
    try {
      _isFetching = true;
      _isError = false;
      notifyListeners();
      final Map<String, dynamic>? response = await request(url, method: 'GET');
      if (response == null) {
        _quotes = [];
        return;
      }
      final List<Quote> newQuotes = [];
      for (final key in response.keys) {
        final quote = Quote.fromJsom({...response[key], 'id': key});
        newQuotes.add(quote);
      }
      _quotes = newQuotes;
    } catch (e) {
      _isError = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> createQuote(Quote quote) async {
    try {
      _isCreating = true;
      notifyListeners();
      final url =
          'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/quotes.json';
      await request(url, method: 'POST', body: quote.toJson());
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }
}
