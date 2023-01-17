import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:videocall1/auth/navigateAuthScreen.dart';
import 'package:videocall1/loginScreen.dart';
import 'package:videocall1/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome to vidFoorti 😎',
          body: 'Chill হবে যখন তখন 🥳 🥳',
          image: Center(
            child: Image.asset('images/1.png'),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(colors: MoreGradientColors.azureLane),
            ),
          ),
        ),
        PageViewModel(
          title: 'Join vidFoorti',
          body: 'সম্পূর্ণ Secure এবং fast ভিডিও কনফারেন্স',
          image: Center(
            child: Image.asset(
              'images/2.png',
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(colors: MoreGradientColors.azureLane),
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigateAuthScreen(),
          ),
        );
      },
      done: Text(
        'Done',
        style: myStyle(20, Colors.black),
      ),
      onSkip: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      showSkipButton: true,
      skip: Text(
        'Skip',
        style: myStyle(20, Colors.black),
      ),
      next: const Icon(
        Icons.arrow_forward_ios,
      ),
    );
  }
}
