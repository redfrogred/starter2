import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Stored.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

  Controller () {
    Utils.log('( Controller.dart ) Controller() class initialized');
  }

  // grab the needed helper classes
  Stored stored = Stored();  

    // initialize the 1x 
    void initApp( BuildContext context) {
      if ( Config.appHasBeenInitialized == true ) { 
        Utils.log('( Controller.dart ) initApp() (denied because it already happened)');
        return;
      }
      else {

        Utils.log('( Controller.dart ) initApp() (1x only, Son!)' );

        //  below is old method
        //  var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        
        double w = MediaQuery.of(context).size.width;
        double h = MediaQuery.of(context).size.width;

        // set the Config sizes...
        Config.deviceWidth = w;
        Config.deviceHeight = h;

        // if screen is narrow, make scaler smaller
        if ( Config.deviceWidth < 321 ) { Config.scaleModifier = 0.5; } 
        // if screen is wide, make scaler bigger
        if ( Config.deviceWidth > 799 ) { Config.scaleModifier = 1.0; } 
 
        // log the height and width
        //Utils.log('( Controller.dart ) initApp() (1x only, Son!) (size = ${ Config.deviceWidth.toString() }x${ Config.deviceHeight.toString() }) and (Config.scaleModifier = ' + Config.scaleModifier.toString() + ')' );
        
        // make sure this init only happens 1x
        Config.appHasBeenInitialized = true;        
        return;
      }
    }





  // =================
  // STORED STUFF
  // =================  


  int? getStoredValue( String key ) {
    return stored.num[ key ];
  }

  void setStoredValue( String key, int num ) {
    Utils.log('(method) Controller.setStoredValue()');
    stored.setVar(key, num);
    stored.num[ key ] = num;
    notifyListeners();
  }

  void factoryReset() {
    Utils.log('(method) Controller.factoryReset()');
    stored.num.forEach((String key, int value) { 
      stored.setVar(key, 0);
      stored.num[ key ] = 0;
    });
    notifyListeners();
    return;
  }



}