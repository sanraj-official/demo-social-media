// ignore_for_file: use_build_context_synchronously

import 'package:demo_social_media/Utils/common_elements.dart';
import 'package:demo_social_media/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/common_functions.dart';
import '../../Utils/constants.dart';
import '../../Utils/custom_decoration.dart';
import '../login_screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  // String? _name;
  // String? _email;
  // String? _password;
  bool passHidden = true;
  final List<TextEditingController> _textEditingControllers = [TextEditingController(),TextEditingController(),TextEditingController()];

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
                //For Name Input
                CommonElements.customTextFormField(
                  _textEditingControllers[0],
                  labelText: "Name",
                  prefixIcon: Icons.perm_identity_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                //For Email Input
                CommonElements.customTextFormField(
                  _textEditingControllers[1],
                  labelText: "Email",
                  prefixIcon: Icons.email_rounded,
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
                    _textEditingControllers[2],
                    labelText: "Password",
                    prefixIcon: Icons.lock_outline_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      else if (value.length < 6)
                      {
                        return 'Password should be greater than 5 digits';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonElements.commonButton(
                      text: "Back",
                      onPressAction: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                    ),
                    CommonElements.commonButton(
                      text: "Signup",
                      onPressAction: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          FirebaseAuth.instance.createUserWithEmailAndPassword(email: _textEditingControllers[1].text, password: _textEditingControllers[2].text).then((value){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }).onError((error, stackTrace) async{
                            if(await CommonFunctions.isInternetAvailable()){
                            CommonElements.customSnackBar(context,message: 'Something went wrong') ;
                            }
                            else{
                            CommonElements.customSnackBar(context,message: 'Internet not available !!') ;
                            }
                            debugPrint("Error in Signup : ${error.toString()}");
                          });
                          // TODO: Implement signup logic
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
