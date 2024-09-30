import 'package:everything_app/data/news/news_shared_preferences_repo.dart';
import 'package:everything_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../../data/user/user_shared_preferences_repo.dart';

class OnboardingScreen extends StatefulWidget {
  final SharedNewsRepo newsRepo;
  final SharedUserRepo userRepo;

  const OnboardingScreen(
      {super.key, required this.newsRepo, required this.userRepo});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // index to switch screens
  int index = 0;

  void nextScreen() {
    setState(() {
      index = index + 1;
    });
    if (index == 3) {
      moveToSignIn();
    }
  }

  //Future.delayed(const Duration(seconds: 4)), () {}

  void moveToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignInPage(
                  userRepo: widget.userRepo,
                  newsRepo: widget.newsRepo,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          onBoardPad(context, index),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 17.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: moveToSignIn, child: const Text("Skip")),
                ElevatedButton(
                    onPressed: nextScreen, child: const Text("Next")),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

Widget onBoardPad(context, index) {
  switch (index) {
    case 0:
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/people_reading_news.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 17.0, right: 10),
            child: Text(
              "Welcome to News, Keeping You Updated With Modern Times",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 17.0, right: 10),
            child: Text(
              "Knowledge is a universal force of nature, it binds the ignorant and saves the learned. Like rain that waters the land, knowledge nourishes the mind, opening doors and breaking chains of ignorance. Those who reject it remain stuck, like fish in shallow water, unable to swim into deeper truths. But for those who seek knowledge, it clears the way, showing the road ahead. It guides, empowers, and brings light where there was darkness. In the end, knowledge is the key that unlocks progress—for individuals and for the nation.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    case 1:
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/old_people_newspaper.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 17.0, right: 10),
            child: Text(
              "For Everybody!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 17.0, right: 10),
            child: Text(
              "Knowledge has a way of bringing us together, whether it be young or the old, having something to talk about increases our social interactions with each other. I mean, what else to talk about if not something new and exciting that is generally known by everyone, what else to talk about if not News?",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    case 2:
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/people_laughing.webp',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 17.0, right: 10),
            child: Text(
              "Join Us",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 17.0, right: 10),
            child: Text(
              "We are a community of like minded individuals, geared up towards enjoying all this life has to offer. Wouldn't you like to find out what makes us happy? Wouldn't you like to hear; The News?",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
  }
  return const Text("go home");
}
