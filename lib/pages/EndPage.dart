// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../pages/_AllPages.dart';
import '../widgets/_AllWidgets.dart';

class EndPage extends StatefulWidget {
  const EndPage({super.key});

  @override
  State createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {

  _EndPageState() {
    Utils.log('<<< ( EndPage.dart ) init >>>', 2, true );
  }

  // (this page) variables
  static const String _fileName = 'EndPage.dart';
  final double _scale32 = 32*Config.scaleModifier;

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
          appBar: MyAppBarWidget( 'EndPAGE',),
          // drawer: DrawerWidget(),
          body: Stack(
            children: [
              
              // FIRST STACK LEVEL
              Container(
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

              // TOPMOST STACK LEVEL
              Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                  onDoubleTap: () { 
                      Utils.log('( $_fileName ) (event) doubleTapped (version)');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DebugPage())
                      );  
                  },
                  child: Text(
                    'ver ' + Utils.getSimpleVersion(), 
                    style: TextStyle( fontSize: _scale32 ), ),  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}