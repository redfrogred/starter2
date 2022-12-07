import 'dart:async';
import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget( { super.key } );

  // appbar title ( passed in constructor )
  final String _fileName = 'DrawerWidget.dart';
  final Color _color = Color(0xFF333333); 

  // create an associative array that pairs
  // String "labels" with their icons
  Map<String, IconData> icn = {
    //'Select Toggle'       : Icons.select_all,
    'Timer'             : Icons.hourglass_bottom,
    'Set Time'          : Icons.watch_later,
    'Settings'          : Icons.settings,
    'About'             : Icons.info_outline
  };

  ListTile _getNavItem( context, String label ) {
    return ListTile(
      leading: Container(
        child: Icon( icn[label], color: Colors.white, size: 64*Config.scaleModifier, ),
        padding: EdgeInsets.fromLTRB(0,5*Config.scaleModifier,0,0),
      ),
      title: Text( label, style: TextStyle( color: Colors.white, fontSize: 36*Config.scaleModifier )),
      minLeadingWidth: 80*Config.scaleModifier,
      minVerticalPadding: 30*Config.scaleModifier,
      onTap: () {
        //Log.info('(method) Drawer_Widget._getNavItem() tapped ' + label);

        switch( label ) {
          case 'Timer': { 
            Utils.log('( $_fileName ) clicked "Timer"');
            Navigator.of(context).pop();
          }
          break;
          case 'Set Time' : {
            Navigator.of(context).popAndPushNamed('SetPage');
          }
          break;          
          case 'Settings' : {
            Navigator.of(context).popAndPushNamed('SettingsPage');
          }
          break;
          case 'About' : {
            Navigator.of(context).popAndPushNamed('AboutPage');
          }
          break;          
          default: { 
            Utils.log('( $_fileName ) could not find match for tap!"');
            Navigator.pop(context);
          }
          break;
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, 
      child: Drawer(
        backgroundColor: Color(0xFF1a1a1a),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22,30,22,0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/logo_1.png"),
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    //color: Colors.red,
                  ),
                ),
              ),
            ),
            
            
            // START "Drawer Items"
            _getNavItem( context, 'Timer'),         
            Divider( color: _color ),          
            _getNavItem( context, 'Set Time'),
            Divider( color: _color ),
            //_getNavItem( context, 'Profile'),
            _getNavItem( context, 'Settings'),
            Divider( color: _color ),
            _getNavItem( context, 'About'),
            Divider( color: _color ),
            // END "Drawer Items"
    
          ],
        ),
      ),
    );
  }
}