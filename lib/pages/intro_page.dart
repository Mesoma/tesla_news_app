import 'package:everything_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)=> SignInPage()
          )
      );
     }
    );
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
            Colors.red.withOpacity(0.02),
            Colors.red.withOpacity(0.05),
            Colors.red.withOpacity(0.09),
            Colors.red.withOpacity(0.15),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
            ),
           )
          ),
          Center(
            child: Image.asset(
              'assets/images/news_logo.jpg',
              height: 200,
              width: 200,
            ),
          )
        ],
      )
    );
  }
}
