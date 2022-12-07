// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../classes/Utils.dart';
import '../pages/_AllPages.dart';
import '../widgets/_AllWidgets.dart';

class StartPage extends StatefulWidget {
  const StartPage({ super.key });

  @override
  State createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  _StartPageState() {
    Utils.log('<<< ( StartPage.dart ) init >>>', 2, true );
  }

  // (this page) variables
  static const String _fileName = 'StartPage.dart';
  
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
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
          appBar: MyAppBarWidget( 'StartPAGE',),
          drawer: DrawerWidget(),
          body: Container(
            color: Colors.transparent,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Utils.log('( $_fileName ) (event) clicked "go to EndPage()"');
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EndPage())
                  );                
                },
                child: Text( 'Go to EndPage()' ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}