import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:videocall1/variables.dart';
import 'package:videocall1/registerScreen.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();

  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String userName = '';

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
    });
  }

  codeJoinMetting() async {
    try {
      Map<FeatureFlagEnum, bool> feaatureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        feaatureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userDisplayName =
            namecontroller.text == '' ? userName : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 6.5,
                  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: MoreGradientColors.azureLane),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Secret code',
                style: myStyle(
                  30,
                  Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                controller: roomcontroller,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context,
                autoDisposeControllers: false,
                animationType: AnimationType.slide,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box, activeColor: Colors.blue),
                animationDuration: Duration(milliseconds: 300),
                length: 6,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Leave it Blank if you want your profile name',
                  hintText: 'Alternative Name',
                  labelStyle: myStyle(15),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  'Mute video',
                  style: myStyle(20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  'Mute Sound',
                  style: myStyle(20),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => codeJoinMetting(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient:
                        LinearGradient(colors: MoreGradientColors.azureLane),
                  ),
                  child: Center(
                    child: Text(
                      'Join Video Call',
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
      ),
    );
  }
}
