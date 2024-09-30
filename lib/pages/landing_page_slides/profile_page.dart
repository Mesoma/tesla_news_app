import 'package:everything_app/data/user/user_shared_preferences_repo.dart';
import 'package:flutter/material.dart';

import '../../data/news/news_shared_preferences_repo.dart';
import '../sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  final String user;
  final SharedUserRepo userRepo;
  final SharedNewsRepo newsRepo;

  const ProfilePage(
      {super.key,
      required this.user,
      required this.userRepo,
      required this.newsRepo});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.person,
              size: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Username: ",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  widget.user,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Last Seen: ",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Just Now",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () => logout(context), child: const Text("Log Out"))
          ],
        ),
      ),
    );
  }
}
