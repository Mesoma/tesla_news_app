import 'package:everything_app/data/user/user_shared_preferences_repo.dart';
import 'package:everything_app/domain/user/user_model.dart';
import 'package:everything_app/pages/landing_page.dart';
import 'package:everything_app/pages/onboarding_screens/onboarding.dart';
import 'package:flutter/material.dart';

import '../data/news/news_shared_preferences_repo.dart';

class SplashScreen extends StatefulWidget {
  final SharedUserRepo userRepo;
  final SharedNewsRepo newsRepo;

  const SplashScreen(
      {super.key, required this.userRepo, required this.newsRepo});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void authUser(User user) {
    if (user.isLoggedIn) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LandingPage(
                      username: user.username,
                      userRepo: widget.userRepo,
                      newsRepo: widget.newsRepo,
                    )));
      });
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OnboardingScreen(
                      userRepo: widget.userRepo,
                      newsRepo: widget.newsRepo,
                    )));
      });
    }
  }

  Future<void> checkAuthUser() async {
    final user = await widget.userRepo.getUser();

    authUser(User(username: user.username, isLoggedIn: user.isLoggedIn));
  }

  @override
  void initState() {
    checkAuthUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white70,
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.withOpacity(0.05),
                Colors.blue.withOpacity(0.07),
                Colors.blue.withOpacity(0.13),
                Colors.blue.withOpacity(0.2),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            )),
        Center(
          child: Image.asset(
            'assets/images/news_final_logo.png',
            height: 200,
            width: 200,
          ),
        )
      ],
    ));
  }
}
