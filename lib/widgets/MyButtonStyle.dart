// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class MyButtonStyle {
  // (this page) variables
  static const String _fileName = 'MyButtonStyle.dart';  
  // scaling modifiers 
  final double _scale14 = 14*Config.scaleModifier;
  final double _scale24 = 24*Config.scaleModifier;
  final double _scale32 = 32*Config.scaleModifier;

  ButtonStyle btnPadding () {

      Utils.log( 'btn() called ' + _scale24.toString());
      
      return ButtonStyle(
      // backgroundColor: MaterialStateProperty.all<Color>(Config.colorButtons),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return EdgeInsets.fromLTRB( _scale24, _scale14, _scale24, _scale14 );
          }
          return EdgeInsets.fromLTRB( _scale24, _scale14, _scale24, _scale14 );
        },
      )
    );
  }

  TextStyle btnText () {

      Utils.log( 'btn() called ' + _scale24.toString());
      
      return TextStyle(
      // backgroundColor: MaterialStateProperty.all<Color>(Config.colorButtons),
      fontSize: _scale32,
    );
  }

}