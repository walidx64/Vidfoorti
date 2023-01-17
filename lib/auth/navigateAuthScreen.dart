import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:videocall1/FadeAnimation.dart';
import 'package:videocall1/loginScreen.dart';
import 'package:videocall1/registerScreen.dart';
import 'package:videocall1/variables.dart';

class NavigateAuthScreen extends StatefulWidget {
  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: MoreGradientColors.azureLane),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                FadeAnimation(
                    1,
                    Text(
                      "Welcome to vidFoorti 😎",
                      style: myStyle(28, Colors.black),
                    )),
                // SizedBox(
                //   height: 10,
                // ),
                // FadeAnimation(
                //     1.2,
                //     Text(
                //       "Automatic identity verification which enables you to verify your identity",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(color: Colors.grey[700], fontSize: 15),
                //     )),
              ],
            ),
            Divider(
              height: 10,
              thickness: 2.0,
            ),
            FadeAnimation(
                1.4,
                Container(
                  height: MediaQuery.of(context).size.height / 2.8,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('images/3.png'))),
                )),
            Column(
              children: <Widget>[
                FadeAnimation(
                    1.5,
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Login",
                        style: myStyle(20, Colors.black),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    1.6,
                    Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        color: Colors.deepPurple,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Sign up",
                          style: myStyle(20, Colors.black),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Color(0xffE3F1FF),
    //   body: Stack(
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height / 2,
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(colors: MoreGradientColors.azureLane),
    //         ),
    //         child: Center(
    //           child: Image.asset('images/3.png'),
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: Container(
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
