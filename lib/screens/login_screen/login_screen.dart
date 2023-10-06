// ignore_for_file: use_build_context_synchronously

import 'package:demo_social_media/Utils/common_functions.dart';
import 'package:demo_social_media/Utils/common_widgets.dart';
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
  bool passVisibility = false;
  final List<TextEditingController> _textEditingControllers = [TextEditingController(),TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  controller: _textEditingControllers[0],
                  validator: (value) {
                    if (!emailRegex.hasMatch(value??"")) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //_id = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration:  InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passVisibility = !passVisibility;
                        });
                      },
                      icon: Icon(passVisibility ? Icons.visibility : Icons.visibility_off),
                    )
                  ),
                  controller: _textEditingControllers[1],
                  obscureText: passVisibility,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                   // _password = value;
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CommonWidgets.commonButton(
                        text: "Signup",
                        onPressAction: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                        },
                      ),
                      CommonWidgets.commonButton(
                        text: "Login",
                        onPressAction: () async{

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _auth.signInWithEmailAndPassword(email: _textEditingControllers[0].text, password: _textEditingControllers[1].text).then((value){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()));
                            }).onError((error, stackTrace) async{
                              if(await CommonFunctions.isInternetAvailable()){
                                CommonWidgets.customSnackBar(context,message: 'Invalid Credentials') ;
                              }
                              else{
                                CommonWidgets.customSnackBar(context,message: 'Internet not available !!') ;
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
                    _auth.sendPasswordResetEmail(email: _textEditingControllers[0].text).then((value){
                      CommonWidgets.customSnackBar(context,message: 'Reset link mailed to ${_textEditingControllers[0].text}') ;
                    }).onError((error, stackTrace){
                      debugPrint("${_textEditingControllers[0].text} Forgot Password Error : ${error.toString()}");
                    });
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
