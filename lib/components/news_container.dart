import 'dart:convert';
import 'dart:math';
import 'package:everything_app/data/news/news_shared_preferences_repo.dart';
import 'package:everything_app/domain/news/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsContainer extends StatefulWidget {
  final int index;
  final SharedNewsRepo newsRepo;

  const NewsContainer({super.key, required this.index, required this.newsRepo});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  //Response Variable
  Map mapResponse = {};

  // Article List
  List listOfArticles = [];
  List filteredArticles = [];

  //function to fetch API data
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&apiKey=64f37d75dc4445a190721959cf45cd83'));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfArticles = mapResponse['articles'];
      });
    }
  }

  // function to bookmark news
  void bookmarkNews(int index) {
    // Convert map to News object
    var articleMap = listOfArticles[index];
    News news = News(
      author: articleMap['author'],
      index: index,
      headline: articleMap['title'],
      body: articleMap['description'] + " " + articleMap['content'],
      provider: articleMap['source']['name'],
    );

    // Save bookmark
    widget.newsRepo.saveBookmark(news);

    // Dialog Box for user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bookmark Saved'),
          content: const Text('This article has been added to your bookmarks.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    int randomNumber = random.nextInt(30);

    return (listOfArticles.isEmpty || mapResponse.isEmpty)
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: Colors.white,
            body: const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 6.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text("Loading",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
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
                      "Author: ${listOfArticles[widget.index]['author']} ",
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
                          const Text(
                            "BBC News",
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                      child: Image(
                        image:
                            listOfArticles[widget.index]['urlToImage'] != null
                                ? NetworkImage(
                                    listOfArticles[widget.index]['urlToImage'])
                                : const AssetImage('assets/images/news1.jpg'),
                        fit: BoxFit.fitWidth,
                      )),
                  const SizedBox(height: 10),
                  Text(" ${listOfArticles[widget.index]['title']} ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  const SizedBox(height: 10),
                  Text(
                    "${listOfArticles[widget.index]['description']} ",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    " ${listOfArticles[widget.index]['content']} ",
                  ),
                  const SizedBox(height: 40),

                  // ElevatedButton to add to bookmarks
                  ElevatedButton(
                    onPressed: () {
                      bookmarkNews(widget.index);
                    },
                    child: const Text("Add to Bookmarks"),
                  )
                ],
              ),
            ),
          );
  }
}
