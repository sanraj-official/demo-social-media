// ignore_for_file: use_build_context_synchronously

import 'package:demo_social_media/Utils/common_functions.dart';
import 'package:demo_social_media/Utils/common_elements.dart';
import 'package:demo_social_media/Utils/custom_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/constants.dart';
import '../home_screen/home_screen.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // String? _id;
  // String? _password;
  bool passHidden = true;
  final List<TextEditingController> _textEditingControllers = [
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonElements.customAppBar(
        title: 'Demo Media',
      ),
      // extendBodyBehindAppBar: true,
      body: Container(
        decoration: CustomDecoration.homeBackground(),
        padding: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //For Email Input
                CommonElements.customTextFormField(
                  _textEditingControllers[0],
                  labelText: "Email",
                  prefixIcon: Icons.perm_identity_rounded,
                  validator: (value) {
                    if (!emailRegex.hasMatch(value ?? "")) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                //For Password Input
                CommonElements.customTextFormField(
                  _textEditingControllers[1],
                  labelText: "Password",
                  prefixIcon: Icons.lock_outline_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  suffixWidget: IconButton(
                    onPressed: () {
                      setState(() {
                        passHidden = !passHidden;
                      });
                    },
                    icon: Icon(passHidden
                        ? Icons.visibility
                        : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                  isPassword: passHidden
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CommonElements.commonButton(
                        text: "Signup",
                        backgroundColor: Colors.purpleAccent,
                        onPressAction: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                        },
                      ),
                      CommonElements.commonButton(
                        text: "Login",
                        backgroundColor: Colors.indigoAccent,
                        onPressAction: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _auth
                                .signInWithEmailAndPassword(
                                    email: _textEditingControllers[0].text,
                                    password: _textEditingControllers[1].text)
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            }).onError((error, stackTrace) async {
                              if (await CommonFunctions.isInternetAvailable()) {
                                CommonElements.customSnackBar(context,
                                    message: 'Invalid Credentials');
                              } else {
                                CommonElements.customSnackBar(context,
                                    message: 'Internet not available !!');
                              }

                              debugPrint("Login Error : ${error.toString()}");
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if(_textEditingControllers[0].text.isEmpty)
                      {
                        CommonElements.customSnackBar(context,
                            message:
                            "Please enter email id and then try again ...");
                      }
                    else if (!emailRegex.hasMatch(_textEditingControllers[0].text)) {
                      CommonElements.customSnackBar(context,
                          message:'Please enter a valid email address and try again ..');
                    }
                    else {
                      _auth
                          .sendPasswordResetEmail(
                          email: _textEditingControllers[0].text)
                          .then((value) {
                        CommonElements.customSnackBar(context,
                            message:
                            'Reset link mailed to ${_textEditingControllers[0]
                                .text}, if account exist');
                      }).onError((error, stackTrace) {
                        debugPrint(
                            "${_textEditingControllers[0]
                                .text} Forgot Password Error : ${error
                                .toString()}");
                      });
                    }
                  },
                  child: const Text('Forgot Password?',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
