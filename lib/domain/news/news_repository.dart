import 'package:everything_app/domain/news/news_model.dart';

abstract class NewsRepo {
  Future<List> getBookmarks();

  Future<News> getNews(int index);

  Future<void> saveBookmark(News news);

  Future<void> clearBookmarks(List news);

  Future<void> deleteBookmark(News news);
}
