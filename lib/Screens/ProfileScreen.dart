import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:videocall1/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  bool dataIsThere = false;
  TextEditingController usernamecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      userName = userDoc.data()['username'];
      dataIsThere = true;
    });
  }

  editProfile() async {
    userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'username': usernamecontroller.text});
    setState(() {
      userName = usernamecontroller.text;
    });
    Navigator.pop(context);
  }

  openEditProfileDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: usernamecontroller,
                    style: myStyle(18, Colors.black),
                    decoration: InputDecoration(
                        labelText: 'Update Name/নাম পরিবর্তন',
                        labelStyle: myStyle(16, Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () => editProfile(),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: MoreGradientColors.azureLane),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataIsThere == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.8,
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: MoreGradientColors.azureLane),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 90,
                    top: MediaQuery.of(context).size.height / 5,
                  ),
                  child: AvatarGlow(
                    glowColor: Colors.blue,
                    endRadius: 90,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Image.asset(
                          'images/5.png',
                        ),
                        radius: 64.0,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        userName,
                        style: myStyle(40, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => openEditProfileDialog(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: MoreGradientColors.azureLane),
                          ),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: MoreGradientColors.azureLane),
                          ),
                          child: Center(
                            child: Text(
                              'LogOut',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
