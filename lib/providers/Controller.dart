// ignore_for_file: prefer_conditional_assignment, file_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:starter2/classes/Date.dart';
import '../classes/Config.dart';
import '../classes/Stored.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

  // (this class) variables
  static const double _version = 1.01;              // the version of this class last updated October, 2022
  static const String _fileName = 'Controller.dart';
  static const bool   _verbose = false;             // true = show detailed log

  Controller () {
    Utils.log('( $_fileName ) class initialized (v.${ _version.toString() })'); 
  }

  // grab the needed helper classes
  Stored stored = Stored();  

  // use local storage as if it is a cookie!
  final cookie = GetStorage();
  static int            _appLoadedTotalNum = 0; 
  static int            _deviceWidth = 0;
  static int            _deviceHeight = 0;
  static int            _dateUsedConsecutive = 0;
  static String         _dateUsedFirst = '';
  static String         _dateUsedToday = '';

  // get timestamp right now
  final DateTime _timestamp = Date.makeTimestampAsDateTime();

    // initialize the 1x 
    void initApp( BuildContext context) {
      if ( Config.appHasBeenInitialized == true ) { 
        Utils.log('( $_fileName ) initApp() (denied because it already happened)');
        return;
      }
      else {

        Utils.log('( $_fileName ) initApp() (1x only, Son!)' );

        //  below is old method
        //  var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        
        double w = MediaQuery.of(context).size.width;
        double h = MediaQuery.of(context).size.width;

        // set the Config sizes...
        setDeviceWidth(w); //Config.deviceWidth = w;
        Config.deviceHeight = h;
 
        // log the height and width
        //Utils.log('( Controller.dart ) initApp() (1x only, Son!) (size = ${ Config.deviceWidth.toString() }x${ Config.deviceHeight.toString() }) and (Config.scaleModifier = ' + Config.scaleModifier.toString() + ')' );
        
        // make sure this init only happens 1x
        Config.appHasBeenInitialized = true;        
        return;
      }
    }


    void setDeviceWidth ( double width ) {
      Utils.log('( $_fileName ) setDeviceWidth() to ' + width.toString() );
      Config.deviceWidth = width;
      // if screen is narrow, make scaler smaller
      if ( Config.deviceWidth < 321 ) { Config.scaleModifier = 0.5; } 
      // if screen is wide, make scaler bigger
      if ( Config.deviceWidth > 799 ) { Config.scaleModifier = 1.0; } 
    }

    void initStorage() {

      // get the today as "2022-12-25"  
      _dateUsedToday = Date.getFriendlyDate( _timestamp );

      // read the cookie      
      if ( cookie.read('appLoadedTotalNum') == null ) {
        // *** THIS IS THE FIRST TIME THIS APP HAS EVER RUN! ***
        _appLoadedTotalNum = 1;  
        // set the dateUsedFirst and dateUsedToday both to today!
        cookie.write( 'dateUsedFirst', _dateUsedToday );
        cookie.write( 'dateUsedToday', _dateUsedToday );
      }
      else {
        // *** THIS APP HAS RUN BEFORE! ***
        _appLoadedTotalNum = cookie.read('appLoadedTotalNum');
        _appLoadedTotalNum++;
        // *** LEFT OFF HERE
      }

      // do some storage operations
      _dateUsedConsecutive++;

      // write the cookie
      cookie.write('appLoadedTotalNum',_appLoadedTotalNum);


      Utils.log('( $_fileName ) initStorage() | _appLoadedTotalNum = ${ _appLoadedTotalNum.toString() }' );

    }

  // =================
  // STORED STUFF
  // =================  


  int? getStoredValue( String key ) {
    Utils.log('( $_fileName ) getStoredValue()');
    return stored.num[ key ];
  }

  void setStoredValue( String key, int num ) {
    Utils.log('( $_fileName ) setStoredValue()');
    stored.setVar(key, num);
    stored.num[ key ] = num;
    notifyListeners();
  }

  void getStoredValues() {
    String str = '( $_fileName ) getStoredValues()\n---- num ----\n';
    
    // do numbers
    stored.num.forEach((String key, int value) { 
      str += '---- $key: ${ value.toString() }\n';
    });   

    // now do strings
    str += '---- str ---- \n';
    stored.str.forEach((String key, String value) { 
      str += '---- $key: "${ value.toString() }"\n';
    });     
    Utils.log( str ); 
    return;
  }

  void factoryReset() {
    Utils.log('( $_fileName ) factoryReset()');
    stored.num.forEach((String key, int value) { 
      stored.setVar(key, 0);
      stored.num[ key ] = 0;
    });
    stored.str.forEach((String key, String value) { 
      stored.setVar(key, '');
      stored.str[ key ] = '';
    });    
    notifyListeners();
    return;
  }

}


