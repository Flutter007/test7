class Quote {
  final String? id;
  final String categoryId;
  final String author;
  final String quote;
  final DateTime createdAt;

  Quote({
    this.id,
    required this.categoryId,
    required this.author,
    required this.quote,
    required this.createdAt,
  });

  factory Quote.fromJsom(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      categoryId: json['createdAt'],
      author: json['author'],
      quote: json['quote'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'author': author,
      'quote': quote,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
