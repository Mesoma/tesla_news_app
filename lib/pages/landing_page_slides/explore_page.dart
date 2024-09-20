import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExplorePage extends StatefulWidget{
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  //Response Variable
  Map mapResponse = {};

  // Article List
  List listOfArticles = [];

  //function to fetch API data
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&apiKey=64f37d75dc4445a190721959cf45cd83'));

    if(response.statusCode == 200) {
      setState((){
        mapResponse = json.decode(response.body);
        listOfArticles = mapResponse['articles'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return (listOfArticles.isEmpty || mapResponse.isEmpty)
        ? Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Explore"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
              Text("Loading", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      )
      ,
    )
        : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Explore"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listOfArticles.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      newsTile(index, listOfArticles),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget newsTile(int index,  List articles) {

  // for random times
  var random = Random();
  int randomNumber = random.nextInt(30);

  // for shortening text
  String shortenText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  return (articles[index].isEmpty)
      ? const SizedBox()
      : Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0), 
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // News Image
        Image(
          image: articles[index]['urlToImage'] != null
              ? NetworkImage(articles[index]['urlToImage'])
              : const AssetImage('assets/images/news1.jpg'),
          height: 102,
          width: 150,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10), 

        // Column for text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Author: ${articles[index]['author']} ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5), 

              // News headline with text overflow handling
              Text(
                articles[index]['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),

              // News source and time
              Row(
                children: [
                  Image.asset('assets/images/bbc_news_logo.webp', width: 24),
                  const SizedBox(width: 5),

                  // Wrapping the text with Flexible to avoid overflow
                  Text(
                    shortenText(articles[index]['source']['name'], 10),
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

