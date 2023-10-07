import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDecoration{

  static BoxDecoration homeBackground(){
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0XFFCB2B93),
          Color(0XFF9546C4),
          Color(0XFF5E61F4),

        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
      ),
    );
  }

  }