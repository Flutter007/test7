class CategoryOfQuotes {
  final String id;
  final String meaning;

  CategoryOfQuotes({required this.id, required this.meaning});
}

final List<CategoryOfQuotes> categories = [
  CategoryOfQuotes(id: 'all-quotes', meaning: '-All Quotes-'),
  CategoryOfQuotes(id: 'star-wars', meaning: 'Star Wars'),
  CategoryOfQuotes(id: 'famous-people', meaning: 'Famous People'),
  CategoryOfQuotes(id: 'saying', meaning: 'Saying'),
  CategoryOfQuotes(id: 'humor', meaning: 'Humor'),
  CategoryOfQuotes(id: 'motivational', meaning: 'Motivational'),
];
