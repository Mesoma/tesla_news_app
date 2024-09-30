import 'dart:async';
import 'dart:math';
import 'package:everything_app/data/news/news_shared_preferences_repo.dart';
import 'package:everything_app/domain/news/news_model.dart';
import 'package:flutter/material.dart';

class LocalNewsContainer extends StatefulWidget {
  final int index;
  final SharedNewsRepo newsRepo;

  const LocalNewsContainer(
      {super.key, required this.index, required this.newsRepo});

  @override
  State<LocalNewsContainer> createState() => _LocalNewsContainerState();
}

class _LocalNewsContainerState extends State<LocalNewsContainer> {
  // delete bookmark function
  Future<void> removeBookmark(int index) async {
    await widget.newsRepo.deleteBookmark(localNews!);
    await widget.newsRepo.getBookmarks();
  }

  News? localNews;

  Future<void> fetchData(int index) async {
    News news = await widget.newsRepo.getNews(index);
    setState(() {
      localNews = news;
    });
  }

  @override
  void initState() {
    fetchData(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    int randomNumber = random.nextInt(30);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                "Author: ${localNews?.author} ",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/news_circle.jpg',
                    height: 47,
                    width: 47,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      localNews!.provider,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${randomNumber}m ago",
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/bookmark_logo.png',
                  fit: BoxFit.cover,
                )),
            const SizedBox(height: 10),
            Text(" ${localNews?.headline} ",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const SizedBox(height: 10),
            Text(
              "${localNews?.body} ",
            ),
            const SizedBox(height: 50),

            // ElevatedButton to add to bookmarks
            ElevatedButton(
              onPressed: () async {
                // to show a confirmation dialog before removing the bookmark
                bool? confirm = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Removal"),
                      content: const Text(
                          "Are you sure you want to remove this bookmark?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Remove"),
                        ),
                      ],
                    );
                  },
                );

                // If user confirms, remove the bookmark
                if (confirm == true) {
                  await removeBookmark(widget.index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bookmark removed successfully!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context)
                      .pop(true); // Pass true to indicate bookmark was removed
                } else {
                  Navigator.of(context).pop(false); // Pass false if not removed
                }
              },
              child: const Text("Remove Bookmark"),
            )
          ],
        ),
      ),
    );
  }
}
