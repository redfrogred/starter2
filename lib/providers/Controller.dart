// ignore_for_file: prefer_conditional_assignment, file_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:starter2/classes/Date.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

  // (this class) variables
  static const double _version = 1.01;              // the version of this class last updated October, 2022
  static const String _fileName = 'Controller.dart';
  static const bool   _verbose = false;             // true = show detailed log

  Controller () {
    Utils.log('( $_fileName ) class initialized (v.${ _version.toString() })'); 
  }

  // use local storage as if it is a cookie!
  final cookie = GetStorage();
  static int            _appLoadedTotalNum = 0; 
  static int            _deviceWidth = 0;
  static int            _deviceHeight = 0;
  static int            _daysUsedConsecutive = 0;
  static String         _dateUsedFirst = '';
  static String         _dateUsedToday = '';
  static int            _daysSinceLastUse = 0;

  static bool           allSystemsGo = false;

  // get timestamp right now
  final DateTime _timestamp = Date.makeTimestampAsDateTime();

    //  initApp() happens 1x.  It is called from initState of main()...
    //  Basically, it sees if local storage ("cookie") has any values in it
    //  to figure out if this is the first time the app has ever been run. 

    void initApp() {
      // read the cookie      
      if ( cookie.read('appLoadedTotalNum') == null ) {
        // *** THIS IS THE FIRST TIME THIS APP HAS EVER RUN! ***
        _appLoadedTotalNum = 1;  
        // set the dateUsedFirst to today!
        cookie.write( 'dateUsedFirst', Date.getFriendlyDate( _timestamp ));
        cookie.write( 'dateUsedToday', Date.getFriendlyDate( _timestamp ));
        cookie.write( 'daysUsedConsecutive', 0);
        cookie.write( 'daysSinceLastUse', 0);
      }
      else {
        // *** THIS APP HAS RUN BEFORE! ***
        _appLoadedTotalNum = cookie.read('appLoadedTotalNum');
        _appLoadedTotalNum++;
      }

      // write the cookie
      cookie.write('appLoadedTotalNum',_appLoadedTotalNum);
      Utils.log('( $_fileName ) initStorage() | _appLoadedTotalNum = ${ _appLoadedTotalNum.toString() }' );

      refreshApp();
      return;
    }

    //  refresh() happens many times.  It is called from initApp(), as well as
    //  Utils.log when enough time has gone by
    void refreshApp() {
      if ( cookie.read('dateUsedToday') == null ) {
        _dateUsedToday = Date.getFriendlyDate( _timestamp );
        cookie.write('dateUsedToday',_dateUsedToday);
        if ( cookie.read('_daysUsedConsecutive') == null ) {
          _daysUsedConsecutive = 0;
          cookie.write('daysUsedConsecutive',_daysUsedConsecutive);
          _daysSinceLastUse = 0;
          cookie.write('daysSinceLastUse',_daysSinceLastUse);
        }        
      } 
      else {
        _dateUsedToday = cookie.read('dateUsedToday');
        // the stored _dateUsedToday is older than today
        if ( _dateUsedToday != Date.getFriendlyDate( _timestamp ) ) {
          _daysSinceLastUse = Date.getTimeApart( DateTime.parse(_dateUsedToday), _timestamp );
          cookie.write('daysSinceLastUse',_daysSinceLastUse);
          // was app used yesterday?
          _daysUsedConsecutive = cookie.read('daysUsedConsecutive');
          if (_daysSinceLastUse == 1) { 
            _daysUsedConsecutive++;
          }
          else {
            _daysUsedConsecutive = 0;
          }
          cookie.write('daysUsedConsecutive',_daysUsedConsecutive);
        }
      }

      // FETCH DEVICE SIZE (1st from device, if no joy, use cookie...)
      var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
      if( query.width == 0 ) {
        if ( cookie.read('deviceWidth') != null ) {
          _deviceWidth = cookie.read('deviceWidth');
        }
        if ( cookie.read('deviceHeight') != null ) {
          _deviceHeight = cookie.read('deviceHeight');
        }
        if ( _deviceWidth > 0 && _deviceHeight > 0) {
          Utils.log('** FETCHED device size from cookie ***');  
        }
        else {
          Utils.log('** ERROR *** (device size could not be fetched)');
        }
      }
      else {
        Utils.log('** FETCHED device size from window ***');
        setDeviceWidth( query.width, query.height );
        allSystemsGo = true;  
      }

      return;
    }

    void setDeviceWidth ( double width, double height ) {
      Utils.log('( $_fileName ) setDeviceWidth() to ' + width.toString() );
      
      //  just in case this device is being held in landscape mode,
      //  force scaling that should work for all devices...
      if( width > height ) {
        width = 320;
        height = 480;
      }

      Config.deviceWidth = width;
      // if screen is narrow, make scaler smaller
      if ( Config.deviceWidth < 321 ) { Config.scaleModifier = 0.5; } 
      // if screen is wide, make scaler bigger
      if ( Config.deviceWidth > 799 ) { Config.scaleModifier = 1.0; } 

      // write width to cookie!
      if ( width != cookie.read('deviceWidth')) {
        cookie.write( 'deviceWidth', width );
      }

      // write height to cookie!
      if ( height > 0 && (height != cookie.read('deviceHeight')) ) {
        cookie.write( 'deviceHeight', height );
      }    
      return;
    }

    bool getAllSystemsGo() {
      return allSystemsGo;
    }

  // =================
  // STORED STUFF
  // =================  

  void getStoredValues() {
    String str = '( $_fileName ) getStoredValues()\n';
    
    //
    str += '---- appLoadedTotalNum: ${ cookie.read('appLoadedTotalNum') }\n';
    str += '---- deviceWidth: ${ cookie.read('deviceWidth') }\n';
    str += '---- deviceHeight: ${ cookie.read('deviceHeight') }\n';
    str += '---- daysUsedConsecutive: ${ cookie.read('daysUsedConsecutive') }\n';
    str += '---- dateUsedFirst: "${ cookie.read('dateUsedFirst') }"\n';
    str += '---- dateUsedToday: "${ cookie.read('dateUsedToday') }"\n';
    str += '---- daysSinceLastUse: ${ cookie.read('daysSinceLastUse') }\n';
    Utils.log( str ); 
    
    return;
  }

  void factoryReset() {

    Utils.log('( $_fileName ) factoryReset()');
    cookie.erase();
    return;
  }

}


