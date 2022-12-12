// ignore_for_file: file_names

import 'package:intl/intl.dart'; 
import 'Utils.dart';

//  Presenting the "Date" class...
//  This class ... 

class Date {

  static const double _version = 1.01;  // the version of this class last updated November, 2022

  Date() {
    Utils.log('     [[ Date() ver ${ _version.toString() } ]] class ("Date.dart") initialized'); 
    _init();
  }

  void _init() {

  }

  //  START of DATE and TIMESTAMP methods
  //  see: https://dart-tutorial.com/useful-information/date-time-in-dart/

  //  makeTimestampAsDateTime() takes no parameters, and
  //  returns a DateTime like 
  //  "2022-11-27 13:04:26.233525"
  static DateTime makeTimestampAsDateTime() {
    final DateTime now = DateTime.now();
    // Utils.log('( Date.dart ) makeTimestampAsDateTime() returns ' + now.toString());
    return now;
  }  

  //  getRawTimestamp() takes a DateTime and returns 
  //  a String like "2022-11-27 13:04:26.233525" 
  static String getRawTimestamp( DateTime date ) {
    Utils.log('( Date.dart ) getRawTimestamp() returns ' + date.toString() );
    return date.toString();
  }

  //  getFriendlyTimestamp() takes a DateTime and returns 
  //  a String like "2022-11-27 01:11:56" 
  //  (basically, it drops the milliseconds)
  static String getFriendlyTimestamp( DateTime date ) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    // Utils.log('( Date.dart ) getFriendlyTimestamp returns ' + formatter.format(date));
    return formatter.format(date);
  }

  //  getFriendlyDate() takes a DateTime and returns 
  //  a String like "2022-11-27" 
  static String getFriendlyDate( DateTime date ) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Utils.log('( Date.dart ) getFriendlyDate() returns ' + formatter.format(date));
    return formatter.format(date);
  }


  //  getNamedDate() takes a DateTime and returns 
  //  a String like "Nov 27, 2022" 
  static String getNamedDate( DateTime date ) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    Utils.log('( Date.dart ) getNamedDate() returns ' + formatter.format(date));
    return formatter.format(date);
  }  

  //  getFriendlyTime() takes a DateTime and returns 
  //  a String like "1:11pm" 
  static String getFriendlyTime( DateTime date ) {
    final DateFormat formatter = DateFormat('h:mma');
    Utils.log('( Date.dart ) getFriendlyTime() returns ' + formatter.format(date).toLowerCase());
    return formatter.format(date).toLowerCase();
  }


  //  getTimeApart() takes 2 DateTimes and returns 
  //  and an optional String ( defaults to "d" )
  //  an int in days or seconds
  static int getTimeApart( DateTime date1, DateTime date2, [ String unit = 'd'] ) {
    final Duration diff = date1.difference(date2);
    if ( unit == 'd' ) {
      Utils.log('( Date.dart ) getTimeApart returns ' + diff.inDays.toString() + ' d' );
      return diff.inDays;
    }
    else {
      Utils.log('( Date.dart ) getTimeApart returns ' + diff.inSeconds.toString() + ' s' );
      return diff.inSeconds;
    }
  }

  //  getRelativeTimeApart() takes 2 DateTimes and returns 
  //  a human friendly timestamp like
  //  "moments", "22 hours", etc.
  static String getRelativeTimeApart( DateTime date1, DateTime date2 ) {
    final Duration diff = date1.difference(date2);
    final int weeks;
    final int years;

    Utils.log('( Date.dart ) getRelativeTimeApart() returns a String...');

    if ( diff.inSeconds < 120 ) { 
      return 'moments';
    }

    if ( diff.inSeconds < 3599 ) { 
      return (diff.inMinutes).toString() + ' minutes';
    }

    if ( diff.inSeconds < 172800 ) { 
      return (diff.inHours).toString() + ' hours';
    }

    if ( diff.inSeconds < 1209600 ) { 
      return (diff.inDays).toString() + ' days';
    }

    // if it gets here is is over 2 weeks ago
    weeks = ((diff.inDays.toInt()) / 7).round();

    if ( weeks > 104 ) {
      years = ((weeks.toInt()) / 52).round();
      return years.toString() + ' years';
    }
    else {
      if ( weeks > 56 && weeks <= 104 ) {
        return 'over 1 year';
      }
    }

    // finally, if it gets here is it less than 2 years
    return weeks.toString() + ' weeks';
  }

  //  The "convertDateTimeToUnixTimestamp()takes 2 DateTimes and returns 
  //  an int like "1669573727"
  static int convertDateTimeToUnixTimestamp( DateTime date ) {
    double sec = (date.millisecondsSinceEpoch)/1000;
    Utils.log('( Date.dart ) convertDateTimeToUnixTimestamp() returns ' + sec.round().toString() );
    return sec.round();
  }

}