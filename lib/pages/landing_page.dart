import 'package:everything_app/components/bottom_navigation_bar.dart';
import 'package:everything_app/data/news/news_shared_preferences_repo.dart';
import 'package:everything_app/data/user/user_shared_preferences_repo.dart';
import 'package:everything_app/pages/landing_page_slides/bookmark_page.dart';
import 'package:everything_app/pages/landing_page_slides/home_page.dart';
import 'package:everything_app/pages/landing_page_slides/profile_page.dart';
import 'package:everything_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

import 'landing_page_slides/explore_page.dart';

class LandingPage extends StatefulWidget {
  final String username;
  final SharedUserRepo userRepo;
  final SharedNewsRepo newsRepo;

  const LandingPage(
      {super.key,
      required this.username,
      required this.userRepo,
      required this.newsRepo});

  @override
  State<LandingPage> createState() => _HomePageState();
}

class _HomePageState extends State<LandingPage> {
  int _selectedIndex = 0;

  // Declaring an empty list first for pages body
  late List<Widget> _pages;

  void logout(BuildContext context) {
    widget.userRepo.logout();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignInPage(
                  userRepo: widget.userRepo,
                  newsRepo: widget.newsRepo,
                )));
  }

  @override
  void initState() {
    super.initState();

    // Initializing _pages in initState
    _pages = [
      HomePage(
        user: widget.username.isNotEmpty ? widget.username : "User",
        newsRepo: widget.newsRepo,
      ),
      ExplorePage(
        newsRepo: widget.newsRepo,
      ),
      BookmarkPage(
        newsRepo: widget.newsRepo,
      ),
      ProfilePage(
        user: widget.username.isNotEmpty ? widget.username : "User",
        newsRepo: widget.newsRepo,
        userRepo: widget.userRepo,
      ),
    ];
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String currentAppBarTitle = "Home";

  List<String> appBarTitles = ["Home", "Explore", "Bookmarks", "Profile"];

  String setAppBarTitle(List<String> titles, int num) {
    setState(() {
      currentAppBarTitle = titles[num];
    });
    return currentAppBarTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: MyBottomNavBar(
          onTabChange: (index) {
            navigateBottomBar(index);
            setAppBarTitle(appBarTitles, index);
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(currentAppBarTitle),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/images/news_circle.jpg',
              height: 17,
              width: 17,
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => logout(
                context,
              ),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: _pages[_selectedIndex]);
  }
}
