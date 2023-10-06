import 'package:demo_social_media/Utils/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body(){
    return Center(
      child: Container(
        child: CommonWidgets.commonButton(
          text: "Logout",
          onPressAction: (){
            FirebaseAuth.instance.signOut().then((value){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
            }).onError((error, stackTrace){
              debugPrint("Logout error : ${error.toString()}");
            });

          }
        ),
      ),
    );
  }
}
