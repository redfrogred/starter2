// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'Utils.dart';

//  Presenting the "Stored" class...
//  This class uses the shared_preferences package, with the goal
//  of making it super-easy to grab and change Strings and ints
//  locally, very much like cookies in the web world.
//
//  It uses 2 hash maps: 
//  - one for Strings called "str", and
//  - one for ints called "num"
//
//  The "Getter"
//  The magic is in using the hashmaps, where the names of Strings and
//  ints get defined in one place.  These maps are used when the
//  the class first initialized, by looping through the map, and
//  pulling out the corresponding values for each key.  If no key is found
//  an int defaults to 0, and a String defaults to ''.  
//
//  The "Setter"
//  Another piece of magic is in setting a key-value pair.  The method
//  "setVar" detects if the key is a String or an int, and saves
//  the new value accordingly.
//
//  The "num" Map and "str" Map are mandatory, but they can be empty
//  if they are not used.  

class Stored {

  static const double _version = 1.04;  // the version of this class last updated October, 2022

  static late SharedPreferences prefs;

  // create an associative array for all of the stored 
  // integers... if there are no values, use: Map<String, int> num = {}
  Map<String, int> num = {
    'appLoadedTotalNum'           : 0,
    'deviceWidth'                 : 0,
  };

  // create an associative array for all of the stored 
  // integers... if there are no values, use: Map<String, String> str = {}
  Map<String, String> str = {
    'appLastPlayedDate'           : ''
  };

  Stored() {
    Utils.log('     [[ Stored() ver ${ _version.toString() } ]] class ("Stored.dart") initialized', 3, false );  
    init();
  }

  Future init() async  {
    prefs = await SharedPreferences.getInstance();

    // ********************
    // *** GETTER LOOPS ***
    // ********************    

    // first, do INT

    // "num" is hash map (also known as an associative array).  
    // It maps out "num's" into key/value pairs with a big loop...
    if (num.isNotEmpty) {
      Utils.log('Stored() num.length =  ' + num.length.toString());  
      num.forEach((String key, int value) { 
        if ( prefs.getInt(key) != null ) {
          num[key] = prefs.getInt(key)!;
        }
        // below show all the key/value pairs
        // Utils.log ('$key = ${ num[key].toString() } ');
      });
    }
    else {
      Utils.log('Stored() num.length =  0');
    }

    // now, do STRING

    if (str.isNotEmpty) { 
      Utils.log('Stored() str.length =  ' + str.length.toString());  
      str.forEach((String key, String value) { 
        if ( prefs.getString(key) != null ) {
          str[key] = prefs.getString(key)!;
        }
        // below show all the key/value pairs
        //Utils.log ('$key = ${ str[key] } ');
    });
    }
    else {
      Utils.log('Stored() str.length =  0');
    }

    // ### DO NOT INCLUDE
    // ### below calls a custom method 
    incrementAppLoaded();
  }

  // ***************
  // *** SETTER  ***
  // ***************    

  // this checks to see if it is an int or String, and
  // saves the associative array accordingly  
  void setVar ( String k, var v ) {
    Utils.log('(method) Stored.setVar() $k = $v');

    if ( v.runtimeType == String ) {
      prefs.setString(k, v);
      Utils.log('setString $k = "$v"');
    }
    else {
      prefs.setInt(k, v);
      Utils.log('setInt $k = ${ v.toString() }');
    }
    return;
  }

  // ### DO NOT INCLUDE
  // ### this is a custom method 
  void incrementAppLoaded() {
    int? c = num[ 'appLoadedTotalNum' ]!;
    c++;
    num[ 'appLoadedTotalNum' ] = c;
    setVar('appLoadedTotalNum', c);
    Utils.log( 'incrementAppLoaded() | appLoadedTotalNum = ' + num[ 'appLoadedTotalNum' ].toString(), 3, false );  

    //  Is this first ever load? 
    //  If so, add some default cookie values...
    if ( num[ 'appLoadedTotalNum' ]! == 1 ) {
      num[ 'deviceWidth' ] = 0;
      setVar('deviceWidth', 0);
      Utils.log( 'incrementAppLoaded() first time ever so init some cookies...', 3, false );        
    }
  }  

}