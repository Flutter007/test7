import 'package:flutter/material.dart';
import 'package:test7/models/quote.dart';
import '../helpers/request.dart';

class QuotesProvider extends ChangeNotifier {
  List<Quote> _quotes = [];
  String url =
      'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/';
  bool _isFetching = false;
  bool _isError = false;
  bool _isCreating = false;
  bool _isDeleting = false;
  List<Quote> get quotes => _quotes;
  bool get isFetching => _isFetching;
  bool get isError => _isError;
  bool get isCreating => _isCreating;
  bool get isDeleting => _isDeleting;

  Future<void> fetchPosts(String url, String id) async {
    try {
      _isFetching = true;
      _isError = false;
      notifyListeners();
      final Map<String, dynamic>? response = await request(
        id == 'all-quotes' ? url : '$url?orderBy="categoryId"&equalTo="$id"',
        method: 'GET',
      );
      if (response == null) {
        _quotes = [];
        return;
      }
      List<Quote> newQuotes = [];
      for (final key in response.keys) {
        final quote = Quote.fromJson({...response[key], 'id': key});
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

      await request('$url/quotes.json', method: 'POST', body: quote.toJson());
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }

  Future<void> updateQuote(Quote quote) async {
    try {
      _isCreating = true;
      notifyListeners();
      await request(
        '$url/quotes/${quote.id}.json',
        method: 'PUT',
        body: quote.toJson(),
      );
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }

  Future<void> deleteQuote(String id) async {
    try {
      _isDeleting = true;
      notifyListeners();
      await request('$url/quotes/$id.json', method: 'DELETE');
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }
}
