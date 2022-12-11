// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class MyButtonStyle {
  // (this page) variables
  static const String _fileName = 'MyButtonStyle.dart';  
  static const bool _verbose = false;
  // scaling modifiers 
  final double _scale14 = 14*Config.scaleModifier;
  final double _scale24 = 24*Config.scaleModifier;
  final double _scale32 = 32*Config.scaleModifier;

  ButtonStyle btnPadding () {

      if(_verbose) {  Utils.log( '( $_fileName ) btnPadding() called ' ); }
      
      return ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB( _scale24, _scale14, _scale24, _scale14 ),
        elevation: 1,
      );
  }

  TextStyle btnText () {

      if(_verbose) { Utils.log( '( $_fileName ) btnText() called ' ); }
      
      return TextStyle(
      // backgroundColor: MaterialStateProperty.all<Color>(Config.colorButtons),
      fontSize: _scale32,
    );
  }

}