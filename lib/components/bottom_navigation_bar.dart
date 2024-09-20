// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.center,
            color: Colors.grey[400],
            activeColor: Colors.grey.shade700,
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: Colors.grey.shade100,
            tabBorderRadius: 25,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
              GButton(
                  icon: Icons.home,
                  text: "Home"
              ),

              GButton(
                  icon: Icons.explore,
                  text: "Explore"
              ),
              GButton(
                  icon: Icons.bookmark,
                  text: "Bookmark"
              ),
              GButton(
                  icon: Icons.person_2_outlined,
                  text: "Profile"
              ),
            ],
          ),
        )
    );
  }
}
