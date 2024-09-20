import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //search bar controller
  final searchController = TextEditingController();

  //Response Variable
  Map mapResponse = {};

  // Article List
  List listOfArticles = [];
  List filteredArticles = [];

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

  //to check search list
  List searchList (List checklist, String search){
    List articles = [];
    for(int i = 0; i< checklist.length; i++){
      if (
          (checklist[i]['title'] != null &&
          checklist[i]['title'].toLowerCase().contains(search.toLowerCase()))
        ||
              (checklist[i]['author'] != null &&
                  checklist[i]['author'].toLowerCase().contains(search.toLowerCase()))
        ||
              (checklist[i]['source']['name'] != null &&
                  checklist[i]['source']['name'].toLowerCase().contains(search.toLowerCase()))
      ){
        articles.add(checklist[i]);
      }
    }
    return articles;
  }

  void searchFunction (String search){
   setState(() {
     filteredArticles = searchList(listOfArticles, searchController.text);
   });
  }


  @override
  Widget build(BuildContext context) {
    return
      //check if API hasn't called yet and return black container(to avoid red error screen)
      (listOfArticles.isEmpty || mapResponse.isEmpty)
          ? const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hi Username
            Text(
              "Hi ${widget.user}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            TextField(
              controller: searchController,
              onChanged: searchFunction,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
            ),

            const SizedBox(height: 10), 

            // Wrapping everything in a scrollable widget
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trending....... see all row
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text("See all", style: TextStyle(fontSize: 15)),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Trending news image
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image(
                        image: listOfArticles[1]['urlToImage'] != null
                            ? NetworkImage(listOfArticles[1]['urlToImage'])
                            : const AssetImage('assets/images/russian_moskva.jpg'),
                        fit: BoxFit.fitWidth,
                      )

                    ),

                    const SizedBox(height: 15),

                    // Trending news country
                     Text(
                     "Author: ${listOfArticles[1]['author']} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    // Trending news headline
                     Text(listOfArticles[1]['title']),

                    const SizedBox(height: 10),

                    // News media provider, time image, time
                    Row(
                      children: [
                        Image.asset('assets/images/bbc_news_logo.webp', width: 24),
                        const SizedBox(width: 5),
                        const Text(
                          "BBC News",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 15),
                        Image.asset('assets/images/clock.png', width: 24),
                        const SizedBox(width: 5),
                        const Text("4h"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Latest....... see all row
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text("See all", style: TextStyle(fontSize: 15)),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // All, Sports, Politics, Business, Health, Travel
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text("All     "),
                          Text("Sports     "),
                          Text("Politics     "),
                          Text("Business     "),
                          Text("Health     "),
                          Text("Travel     "),
                          Text("Science     "),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // News ListView should now fill the remaining space
                    ListView.builder(
                      shrinkWrap: true, 
                      physics: const NeverScrollableScrollPhysics(), 
                      itemCount: (filteredArticles.isEmpty)
                          ? listOfArticles.length
                          : filteredArticles.length, 
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            newsTile(
                                index,
                                (filteredArticles.isEmpty)
                                    ? listOfArticles
                                    : filteredArticles
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ],
                ),
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
