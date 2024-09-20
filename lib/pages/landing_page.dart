import 'package:everything_app/components/bottom_navigation_bar.dart';
import 'package:everything_app/pages/landing_page_slides/bookmark_page.dart';
import 'package:everything_app/pages/landing_page_slides/home_page.dart';
import 'package:everything_app/pages/landing_page_slides/profile_page.dart';
import 'package:everything_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

import 'landing_page_slides/explore_page.dart';


class LandingPage extends StatefulWidget {

  final String username;
  final String password;

  const LandingPage({super.key, required this.username, required this.password});

  @override
  State<LandingPage> createState() => _HomePageState();
}

class _HomePageState extends State<LandingPage> {

  int _selectedIndex = 0;

  // Declaring an empty list first
  late List<Widget> _pages;

  void logout (BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=> SignInPage()
        )
    );
  }

  @override
  void initState() {
    super.initState();

    // Initializing _pages in initState
    _pages = [
      HomePage(user: widget.username.isNotEmpty ? widget.username : "User"),
      const ExplorePage(),
      const BookmarkPage(),
      ProfilePage(user: widget.username.isNotEmpty ? widget.username : "User", password: widget.password.isNotEmpty ? widget.password : "Null"),
    ];
  }


  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: MyBottomNavBar(
              onTabChange: (index) => navigateBottomBar(index),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Image.asset('assets/images/news_text.png'),
              actions: [
                IconButton(
                   onPressed: () => logout(context), icon: const Icon(Icons.logout),
                )
              ],
            ),
            body: _pages[_selectedIndex]
    );
  }
}
