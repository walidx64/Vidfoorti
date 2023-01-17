import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:videocall1/FadeAnimation.dart';
import 'package:videocall1/registerScreen.dart';
import 'package:videocall1/variables.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: MoreGradientColors.azureLane),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1,
                                Text(
                                  "Login",
                                  style: myStyle(30),
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            FadeAnimation(
                                1.2,
                                Text(
                                  "Login to your account",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[800]),
                                )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: <Widget>[
                              FadeAnimation(
                                1.2,
                                makeInput(
                                  label: "Email",
                                  txtcontroller: emailController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Can not be empty';
                                    }
                                    if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return 'Please enter valid email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              FadeAnimation(
                                1.3,
                                makeInput(
                                  label: "Password",
                                  obscureText: true,
                                  txtcontroller: passwordController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Can not be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        FadeAnimation(
                            1.4,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
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
                                    if (formKey.currentState.validate()) {
                                      try {
                                        int count = 0;
                                        FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                        Navigator.popUntil(context, (route) {
                                          return count++ == 2;
                                        });
                                      } catch (e) {
                                        print(e);

                                        var snackbar = SnackBar(
                                          content: Text(
                                            e.toString(),
                                            style: myStyle(20),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackbar);
                                      }
                                    }
                                  },
                                  color: Colors.greenAccent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )),
                        FadeAnimation(
                            1.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Don't have an account?"),
                                FlatButton(
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.deepPurple),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  FadeAnimation(
                      1.2,
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/4.png'),
                                fit: BoxFit.cover)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput(
      {label,
      obscureText = false,
      TextEditingController txtcontroller,
      validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: validator,
          obscureText: obscureText,
          controller: txtcontroller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
