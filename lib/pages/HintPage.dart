// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../pages/_AllPages.dart';
import '../providers/Controller.dart';
import '../widgets/_AllWidgets.dart';

class HintPage extends StatefulWidget {
  const HintPage({ super.key });

  @override
  State createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {

  _HintPageState() {
    Utils.log('<<< ( HintPage.dart ) init >>>', 2, true );
  }

  // (this page) variables
  static const String _fileName = 'HintPage.dart';
  String _errorStr = '';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log('( $_fileName ) initState()');
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
  }

  @override
  void dispose() {
    Utils.log('( $_fileName ) dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log('( $_fileName ) _buildTriggered()');
    Provider.of<Controller>(context, listen: false).initApp( context );
    if ( Config.deviceWidth > 0 ) {
      setState(() {
        Config.showHint = true;
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        //  as an emergency measure, save the width to storage in
        //  case it is needed when the app loaded in the future...
        Provider.of<Controller>(context, listen: false).setStoredValue( 'deviceWidth', Config.deviceWidth.toInt() );
        Utils.log('( $_fileName ) setStoredValue() used to save Config.deviceWidth...');
      });     
    }
    else {
      Future.delayed(const Duration(milliseconds: 1500), () {
        //  as an emergency measure, use storage to grab width
        //  if possible...
        int storedWidth = Provider.of<Controller>(context, listen: false).getStoredValue( 'deviceWidth')!;
        if ( storedWidth > 0) {
          Utils.log('( $_fileName ) HALLELUJAH!! getStoredValue() was used to load Config.deviceWidth...');
          // Just like in Controller.initApp, set the Config sizes...
          Config.deviceWidth = storedWidth.toDouble();

          // if screen is narrow, make scaler smaller
          if ( Config.deviceWidth < 321 ) { Config.scaleModifier = 0.5; } 
          // if screen is wide, make scaler bigger
          if ( Config.deviceWidth > 799 ) { Config.scaleModifier = 1.0; }
          setState(() {
            Config.showHint = true;
          });
        }
        else {
          setState(() {
            _errorStr = 'ERROR: Config.deviceWidth = 0';
          });
        }
      });     
    }
  }
  
  void _addPostFrameCallbackTriggered( context ) {
    Utils.log('( $_fileName ) _addPostFrameCallbackTriggered()');
  }

  // (this page) build
  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        Utils.log('( $_fileName ) WillPopScope() triggered');
        return true;    // true allows back button (false denies)
      },
      child: 
      
      ( Config. showHint == true ) ?

      SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
          appBar: MyAppBarWidget( 'HintPage',),
          drawer: DrawerWidget(),
          body: Container(
            color: Colors.transparent,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Utils.log('( $_fileName ) (event) clicked "go to StartPage()"');
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => StartPage())
                  );                
                },
                // start of button appearance settings 
                child: Text( 'Go to StartPage()', style: MyButtonStyle().btnText(), ),
                style: MyButtonStyle().btnPadding(),
              ),
            ),
          ),
        ),
      )
      : 
      GestureDetector(
        onDoubleTap: () {
          setState(() {
            Config.showHint = true;
          });          
        },
        child: Container(
          child: Center(child:Text( _errorStr ))
        ),
      )
    );
  }
}