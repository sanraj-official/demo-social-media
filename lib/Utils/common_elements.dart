import 'package:flutter/material.dart';

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

}