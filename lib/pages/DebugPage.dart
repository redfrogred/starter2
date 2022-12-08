// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../classes/Utils.dart';
import '../classes/Config.dart';
import '../widgets/_AllWidgets.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {

  _DebugPageState() {
    Utils.log('<<< ( DebugPage.dart ) init >>>', 2, true );
  }

  // (this page) variables
  static const String _fileName = 'DebugPage.dart';
  final double _scale120 = 120*Config.scaleModifier;
  final double _scale26 = 26*Config.scaleModifier;  
  String? _log; 

  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log('( $_fileName ) initState()');
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
    //  grab latest log
    //  ( it is always a tiny bit stale cuz _buildTriggered() and _addPostFrameCallbackTriggered()
    //    happen after this initState... )
    _log = Config.log;
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
          appBar: MyAppBarWidget( 'DebugPAGE',),
          // drawer: DrawerWidget(),
          body: Column(
            children: [
              Container(
                height: _scale120,
                color: Config.appSecondaryColor,
                child: Row (
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,0,10,0),
                      child: ElevatedButton(
                        onPressed: () {
                          Utils.clearLog();
                          Utils.log('( $_fileName ) (event) clicked "clear"');
                          setState(() {
                            _log = Config.log;
                          });
                        },
                        // start of button appearance settings 
                        child: Text( 'clear', style: MyButtonStyle().btnText(), ),
                        style: MyButtonStyle().btnPadding(),
                      ),
                    ),  
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView (
                      child: Text( _log!, style: TextStyle( fontSize: _scale26  ) ),
                    ),
                  ),
                ),              
              ),
            ],
          ),
        ),
      ),
    );
  }
}