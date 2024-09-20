import 'package:everything_app/pages/landing_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
   SignInPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
              children:[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),

                    //Logo Icon
                    Image.asset(
                      'assets/images/news_logo.jpg',
                      height: 154,
                      width: 154,
                    ),

                    const SizedBox(height: 60),

                    //Sign in your account
                    const Text(
                        "Sign in your account",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        )
                    ),

                    const SizedBox(height: 40),

                    //Column to make sure username and password start together
                    const Padding(
                      padding: EdgeInsets.only( right: 200),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    //username text field
                    Padding(
                      padding: const EdgeInsets.only(left:51, right: 51),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            hintText: "ex: Pyrex",
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5)
                            )
                        ),
                        controller: usernameController,
                      ),
                    ),

                    const SizedBox(height: 15),

                    //password text
                    const Padding(
                      padding: EdgeInsets.only(right: 200),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    //password text field
                    Padding(
                      padding: const EdgeInsets.only(left:51, right: 51),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            hintText: "********",
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5)
                            )
                        ),
                        controller: passwordController,
                      ),
                    ),

                    const SizedBox(height: 55),

                    //sign in container
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> LandingPage(username: usernameController.text, password: passwordController.text,)
                          )
                      ),
                      child: Container(
                        height: 42,
                        width: 288,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent
                        ),
                        child:  const Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          )
      ),
    );
  }
}
