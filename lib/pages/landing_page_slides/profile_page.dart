import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String user;
  final String password;
  const ProfilePage({super.key, required this.user, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
        // Explore Text
        Text(
        "Username: $user",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 20),
              Text(
                "Password: $password",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              ],
            ),
      ),
    );
  }
}
