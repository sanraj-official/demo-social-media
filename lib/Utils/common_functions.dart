import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  static Future<bool> isInternetAvailable() async {
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  } catch (e) {
    // Handle any potential exceptions here, e.g., print the error message.
    debugPrint('Error checking connectivity: $e');
    return false;
  }
}
}
