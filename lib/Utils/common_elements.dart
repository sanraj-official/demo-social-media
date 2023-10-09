import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../screens/login_screen/login_screen.dart';
import 'constants.dart';

class CommonElements{
  CommonElements();
  static Widget commonButton({String text="", Function()? onPressAction,Color backgroundColor=Colors.blueAccent ,Color textColor = Colors.white}){
    return  ElevatedButton(
      onPressed: onPressAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child:   Text( text,style: TextStyle(color: textColor),),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(BuildContext context,{String message = ""})
  {
    return ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(message)),
    );
  }

  static TextFormField customTextFormField(
      TextEditingController textEditingController,
      {String labelText="",
        IconData? prefixIcon,
        IconData? suffixIcon,
        bool isPassword = false,
        Color themeColor = Colors.white,
        String? Function(String? value)? validator,
        Widget ? suffixWidget
      }){
    return TextFormField(
      controller: textEditingController,
      obscureText: isPassword,
      cursorColor: themeColor,
      style: TextStyle(color: themeColor.withOpacity(0.8)),
      decoration: InputDecoration(
        prefixIcon: prefixIcon!=null?Icon(prefixIcon,color: themeColor.withOpacity(0.9),):null,
        suffixIcon: suffixWidget??(suffixIcon!=null ? Icon(suffixIcon,color: themeColor.withOpacity(0.9),):null),
        labelText: labelText,
        labelStyle: TextStyle(color: themeColor.withOpacity(0.9)),
        fillColor: themeColor.withOpacity(0.2),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:  const BorderSide(width: 0,style: BorderStyle.none)
        ),
      ),
      keyboardType: isPassword?TextInputType.visiblePassword:TextInputType.emailAddress ,
      validator: validator,


    );
  }

  static AppBar customAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    PreferredSizeWidget? bottom,
    bool centerTitle = true,
    Color backgroundColor = Colors.black,
    double opacity = 1
  }) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white60
        ),
      ),
      actions: actions,
      leading: leading,
      bottom: bottom,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor.withOpacity(opacity),
    );
  }

  Widget popUpMenu( List<PopupMenuEntry<PopUpOptions>> items,BuildContext context,{Color color = Colors.white60}) {
    items.add(
      const PopupMenuItem<PopUpOptions>(
        value: PopUpOptions.logOut,
        child: Text("Logout"), //deleteButton(state),
      ),
    );
    return PopupMenuButton<PopUpOptions>(
      color: color,
        onSelected: (PopUpOptions item) {

            if(item == PopUpOptions.logOut)
            {
              FirebaseAuth.instance.signOut().then((value){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace){
                debugPrint("Logout error : ${error.toString()}");
              });
            }

        },
        itemBuilder: (BuildContext ctx) => items
    );
  }

  Widget postCard({String imageLink='',String htmlElement=''}){
    return Card(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Visibility(
              visible: imageLink.isNotEmpty,
              child: FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) {
                  // Handle network image loading error here
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset('lib/assets/404_banner.png'),
                  );
                },
                placeholderFit: BoxFit.fitHeight,
                fit: BoxFit.fill,
                fadeInDuration:const Duration(seconds: 1),
                image: NetworkImage(imageLink),
                placeholder:const AssetImage('lib/assets/loading2.gif'),
              ),
            ),
            Visibility(
              visible: htmlElement.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(htmlElement),
                )
            ),
          ],
        ),
      ),
    );
  }
}