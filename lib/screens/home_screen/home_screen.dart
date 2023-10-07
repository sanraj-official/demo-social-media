import 'package:demo_social_media/Utils/common_elements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/custom_decoration.dart';
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
        appBar: CommonElements.customAppBar(
          title: 'Demo Media',
        ),
        body: body(),
      ),
    );
  }

  Widget body(){
    return Container(
      decoration: CustomDecoration.homeBackground(),
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: CommonElements.commonButton(
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
    );
  }
}
