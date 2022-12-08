import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

    // initialize the 1x 
    void initApp( BuildContext context) {
      if ( Config.appHasBeenInitialized == true ) { 
        Utils.log('( Controller.dart ) initApp() (denied because it already happened)');
        return;
      }
      else {
        // var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        Config.deviceWidth = MediaQuery.of(context).size.width; // query.width;
        Config.deviceHeight = MediaQuery.of(context).size.height; // query.height;

        // if screen is narrow, make scaler smaller
        if ( Config.deviceWidth < 321 ) { Config.scaleModifier = 0.5; } 
        // if screen is wide, make scaler bigger
        if ( Config.deviceWidth > 799 ) { Config.scaleModifier = 1.0; } 
 
        // log the height and width
        Utils.log('( Controller.dart ) initApp() (1x only, Son!) (size = ${ Config.deviceWidth.toString() }x${ Config.deviceHeight.toString() }) and (Config.scaleModifier = ' + Config.scaleModifier.toString() + ')' );
        
        // make sure this init only happens 1x
        Config.appHasBeenInitialized = true;        
        return;
      }
    }


    // dummy counter stuff (to prove state works)
    int _count = 0;
    int get count => _count;

    void increment() {
      _count++;
      notifyListeners();
    }



}