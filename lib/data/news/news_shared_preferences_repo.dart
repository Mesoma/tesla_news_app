import 'dart:convert';

import 'package:everything_app/domain/news/news_model.dart';
import 'package:everything_app/domain/news/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedNewsRepo implements NewsRepo {
  @override
  Future<List<News>> getBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the list of bookmarks as strings
    final List<String>? bookmarkStrings = prefs.getStringList('bookmarks');

    // Return empty list if no bookmarks dey
    if (bookmarkStrings == null || bookmarkStrings.isEmpty) {
      return [];
    }

    // to take JSON string back into News
    List<News> bookmarks = bookmarkStrings
        .map((bookmarkString) => News.fromJson(jsonDecode(bookmarkString)))
        .toList();

    return bookmarks;
  }

  @override
  Future<News> getNews(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the list of bookmarks as strings
    final List<String> bookmarkStrings = prefs.getStringList('bookmarks')!;

    // Assuming that the index is valid and within the bounds of the list
    final String bookmarkString = bookmarkStrings[index];

    // get our json string
    var jsonNews = jsonDecode(bookmarkString);

    // Decode the JSON string back to a News object
    News news = News.fromJson(jsonNews);

    return news;
  }

  @override
  Future<void> clearBookmarks(List news) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('bookmarks');
  }

  @override
  Future<void> saveBookmark(News news) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // always get your current list before making changes to it
    List<String>? bookmarkStrings = prefs.getStringList('bookmarks') ?? [];

    var newBookmark = jsonEncode(news.toJson());

    bookmarkStrings.add(newBookmark);

    await prefs.setStringList('bookmarks', bookmarkStrings);
  }

  @override
  Future<void> deleteBookmark(News news) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve existing bookmarks
    List<String>? bookmarkStrings = prefs.getStringList('bookmarks') ?? [];

    bookmarkStrings.removeWhere((bookmark) {
      News prefNews = News.fromJson(jsonDecode(bookmark));
      return prefNews.index == news.index;
    });

    // Save the updated bookmarks back to SharedPreferences
    await prefs.setStringList('bookmarks', bookmarkStrings);
  }
}
