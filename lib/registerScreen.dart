import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:videocall1/FadeAnimation.dart';
import 'package:videocall1/loginScreen.dart';
import 'package:videocall1/variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: MoreGradientColors.azureLane),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "Sign up",
                        style: myStyle(30),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "Create an account, It's free",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
                Form(
                  key: formKey,
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Can not be empty';
                              }
                              return null;
                            },
                            label: "Password",
                            obscureText: true,
                            txtcontroller: passwordController),
                      ),
                      FadeAnimation(
                        1.4,
                        makeInput(
                          label: "Name",
                          txtcontroller: usernameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can not be empty';
                            }
                            if (value.length > 20) {
                              return 'Name must be less than 20 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                    1.5,
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
                          if (formKey.currentState.validate()) {
                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((signeduser) {
                                userCollection.doc(signeduser.user.uid).set({
                                  'username': usernameController.text,
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                  'uid': signeduser.user.uid,
                                });
                              });
                              Navigator.pop(context);
                            } catch (e) {
                              print(e);
                              var snackbar = SnackBar(
                                content: Text(
                                  e.toString(),
                                  style: myStyle(20),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          }
                        },
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    )),
                FadeAnimation(
                  1.6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      FlatButton(
                        child: Text(
                          " Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
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
              fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
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
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
