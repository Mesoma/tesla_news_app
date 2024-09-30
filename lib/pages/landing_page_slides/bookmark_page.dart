import 'dart:math';
import 'package:everything_app/data/news/news_shared_preferences_repo.dart';
import 'package:everything_app/domain/news/news_model.dart';
import 'package:everything_app/components/local_news_container.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  final SharedNewsRepo newsRepo;

  const BookmarkPage({super.key, required this.newsRepo});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  // List to hold bookmarks
  List<News> bookmarks = [];
  bool isLoading = true; // Track loading state

  // Future function to load bookmarks
  Future<void> loadBookmarks() async {
    List<News> fetchedBookmarks = await widget.newsRepo.getBookmarks();

    setState(() {
      bookmarks = fetchedBookmarks;
      isLoading = false; // Set loading to false after fetching
    });
  }

  void openNews(int index) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalNewsContainer(
          index: index,
          newsRepo: widget.newsRepo,
        ),
      ),
    );

    if (res == true) {
      loadBookmarks();
    }
  }

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : bookmarks.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 100.0),
                  child: Text(
                    "You Have No Bookmarks",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => openNews(index),
                        child: newsTile(
                            bookmarks[index]), // Pass News object directly
                      );
                    },
                  ),
                ),
    );
  }
}

// Update newsTile to accept a News object instead of a list
Widget newsTile(News news) {
  // For random times
  var random = Random();
  int randomNumber = random.nextInt(30);

  // Shorten text if it's too long
  String shortenText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // News Image
        Image.asset(
          'assets/images/bookmark_logo.jpg',

          // You might want to use news.urlToImage if available in future
          height: 100,
          width: 100,
          // fit: BoxFit,
        ),
        const SizedBox(width: 10),

        // Column for text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Author: ${news.author}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              // News headline with text overflow handling
              Text(
                news.headline,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),

              // News source and time
              Row(
                children: [
                  Image.asset('assets/images/news_circle.jpg', width: 24),
                  const SizedBox(width: 5),

                  // Wrapping the text with Flexible to avoid overflow
                  Text(
                    shortenText(news.provider, 10), // Use null-aware operator
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(width: 15),
                  Image.asset('assets/images/clock.png', width: 24),
                  const SizedBox(width: 5),
                  Text("${randomNumber}m"),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
