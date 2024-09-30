import 'package:everything_app/data/user/user_shared_preferences_repo.dart';
import 'package:everything_app/domain/user/user_model.dart';
import 'package:everything_app/pages/landing_page.dart';
import 'package:flutter/material.dart';

import '../data/news/news_shared_preferences_repo.dart';

class SignInPage extends StatefulWidget {
  final SharedUserRepo userRepo;
  final SharedNewsRepo newsRepo;

  const SignInPage({super.key, required this.userRepo, required this.newsRepo});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // for checkbox
  bool checkBox = true;

  // login function
  void login(User user) {
    widget.userRepo.login(user);
    // Moving to the landing page if both fields are filled
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LandingPage(
          username: usernameController.text,
          userRepo: widget.userRepo,
          newsRepo: widget.newsRepo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Hello",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
              ),

              const Text(
                "Again!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Colors.blue),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Welcome back you've",
                style: TextStyle(fontSize: 20),
              ),

              const Text(
                "been missed",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(
                height: 45,
              ),

              //Column to make sure username and password start together
              const Text(
                "Username*",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              //username text field
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                controller: usernameController,
              ),

              const SizedBox(height: 15),

              //password text
              const Text(
                "Password*",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              //password text field
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                controller: passwordController,
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: checkBox,
                      onChanged: (value) {
                        setState(() {
                          checkBox = value!;
                        });
                      },
                      activeColor: Colors.blue,
                      visualDensity: VisualDensity.compact),
                  const Text(
                    "Remember me",
                    style: TextStyle(fontSize: 15),
                  ),
                  const Spacer(),
                  const Text(
                    "Forgot the password?",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                ],
              ),

              //sign in container
              GestureDetector(
                onTap: () {
                  // Check if both username and password are filled
                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    // Alert dialog if Username and/or Password are empty
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "Username or Password cannot be empty."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    login(User(username: usernameController.text));
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blueAccent,
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 128.0),
                child: Text(
                  "or continue with",
                  style: TextStyle(fontSize: 15),
                ),
              ),

              const SizedBox(height: 13),
              Row(
                children: [
                  Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/facebook_logo.png',
                            height: 20,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.6)),
                          )
                        ],
                      )),
                  const Spacer(),
                  Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            height: 20,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.6)),
                          )
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 13),
              const Padding(
                padding: EdgeInsets.only(left: 80.0),
                child: Row(
                  children: [
                    Text("don't have an account?"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
