import 'package:everything_app/data/news/news_shared_preferences_repo.dart';
import 'package:everything_app/data/user/user_shared_preferences_repo.dart';
import 'package:everything_app/domain/user/user_repository.dart';
import 'package:everything_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final SharedUserRepo db = SharedUserRepo();
  final SharedNewsRepo nb = SharedNewsRepo();

  runApp(MyApp(
    mainRepo: db,
    newsRepo: nb,
  ));
}

class MyApp extends StatelessWidget {
  final SharedUserRepo mainRepo;
  final SharedNewsRepo newsRepo;

  const MyApp({super.key, required this.mainRepo, required this.newsRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(userRepo: mainRepo, newsRepo: newsRepo),
    );
  }
}
