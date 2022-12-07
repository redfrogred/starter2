// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class MyAppBarWidget extends StatelessWidget  implements PreferredSizeWidget {
  MyAppBarWidget( this.passedTitle, { super.key } );

  // appbar title ( passed in constructor )
  final String passedTitle; 
  // scaling modifiers 
  final double _scale80 = 80*Config.scaleModifier;
  final double _scale76 = 76*Config.scaleModifier;
  final double _scale48 = 48*Config.scaleModifier;  

  @override
  //  see "custom app bars" at:
  //  https://stackoverflow.com/questions/53411890/how-can-i-have-my-appbar-in-a-separate-file-in-flutter-while-still-having-the-wi
  //  Size get preferredSize => Size.fromHeight(kToolbarHeight);  
  Size get preferredSize => Size.fromHeight(_scale76);

  @override
  Widget build(BuildContext context) {
    return PreferredSize (
      preferredSize: preferredSize,
      child: AppBar(
        toolbarHeight: _scale76,
        title: Text( passedTitle ),
        leadingWidth: _scale80,             
        actions: [
          IconButton(
            icon: const Icon( Icons.close  ),
            onPressed: () {
              Navigator.pop(context);
              Utils.log('( _fileName ) (event) clicked "x"');
            },              
          ),  
        ],  
      ),
    );
  }
}