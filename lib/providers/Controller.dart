import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

    // initialize the 1x 
    void initApp() {
      if ( Config.appHasBeenInitialized == true ) { 
        Utils.log('( Controller.dart ) initApp() (denied because it already happened)');
        return;
      }
      else {
        var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        double w = query.width;
        Config.deviceWidth = w;
        Config.deviceHeight = query.height;

        // if screen is narrow, make scaler smaller
        if ( Config.deviceWidth < 321 ) { Config.scaleModifier = 0.5; } 
        // if screen is wide, make scaler bigger
        if ( Config.deviceWidth > 799 ) { Config.scaleModifier = 1.0; } 
        
        
        Config.appHasBeenInitialized = true;         
        Utils.log('( Controller.dart ) initApp() (1x only) (size = ${ Config.deviceWidth.toString() }x${ Config.deviceHeight.toString() }) and (Config.scaleModifier = ' + Config.scaleModifier.toString() + ')' );
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