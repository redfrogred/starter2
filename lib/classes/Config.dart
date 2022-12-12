// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Config {
  
  static const  String  appName                   = "starter2";
  static const  String  appVersion                = "1.0.e.002";

  static        bool    appHasBeenInitialized     = false;

  static String         log                       = "";
  
  static double         deviceWidth               = 0;
  static double         deviceHeight              = 0;
  static double         scaleModifier             = 0.6;  //  this is the right value for 
                                                          //  a modern phone (like my S22)  

  static const Color    appBackgroundColor        = Color(0xFFf9feff); // Colors.amber; //  
  static const Color    appBarColor               = Color(0xFF2196f3);
  static const Color    appBarTextColor           = Color(0xFFffffff); // Colors.yellow; // 
  static       Color    appButtonColor            = Color(0xFF2196f3); // Colors.yellow; //  
  static const Color    appButtonTextColor        = Color(0xFFffffff); // Colors.red; //  
  static const Color    appTextColor              = Color(0xFF000000); // Colors.green; //  

  static const Color    appSecondaryColor         = Color(0xFFeeeeee); // Colors.pink; //  

  static bool           showHint                  = false;



}