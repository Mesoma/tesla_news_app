class News {
  final int index;
  final String headline;
  final String body;
  final String author;
  final String provider;

  News(
      {required this.index,
      required this.headline,
      required this.body,
      required this.author,
      required this.provider});

  // Convert News object to Map for storage
  Map<String, dynamic> toJson() => {
        'index': index,
        'headline': headline,
        'body': body,
        'author': author,
        'provider': provider,
      };

  // Convert Map to News object for display in our App
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      index: json['index'],
      headline: json['headline'],
      body: json['body'],
      author: json['author'],
      provider: json['provider'],
    );
  }
}
