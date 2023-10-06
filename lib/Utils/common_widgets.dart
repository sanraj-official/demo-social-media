import 'package:flutter/material.dart';

class CommonWidgets{
  CommonWidgets();
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

}