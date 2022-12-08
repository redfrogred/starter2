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
    setState(() {
      Config.showHint = true;
    });
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
      Container()
    );
  }
}