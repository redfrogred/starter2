import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './providers/Controller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './classes/Config.dart';
import './classes/Utils.dart';
import './classes/Date.dart';
import './pages/_AllPages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // prevent turning phone (landscape not allowed, Son!)
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
      ],
      child: const MyApp(),
    ));
  });
  // hmm
  Future.delayed(const Duration(milliseconds: 1000), () {
    FlutterNativeSplash.remove();
  });     
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  _MyAppState() {
    DateTime timestamp = Date.makeTimestampAsDateTime();
    Utils.log('<<< ( main.dart ) init version ${ Config.appVersion } at ${ Date.getFriendlyTimestamp(timestamp) } >>>', 2, true );
  }

  // (this page) variables
  static const String _fileName = 'main.dart';
  /*
  double? _scale14;
  double? _scale24;
  double? _scale32;    
  double? _scale48;   
  */
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log('( $_fileName ) initState()');
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
    Provider.of<Controller>(context, listen: false).initApp();
    // init the app
    /*
    Provider.of<Controller>(context, listen: false).initApp();
    
    _scale14 = 14*Config.scaleModifier;
    _scale24 = 24*Config.scaleModifier;
    _scale32 = 32*Config.scaleModifier;      
    _scale48 = 48*Config.scaleModifier; 
    */
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    Utils.log('( $_fileName ) dispose()');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) { 
    super.didChangeAppLifecycleState(state);
    // Utils.log('<<< didChangeAppLifecycleState() >>>');
    switch(state) { 
      case AppLifecycleState.paused: { 
        Utils.log('<--- AppLifecycleState.paused --->'); 
        // paused means app moved to background
      } 
      break; 
      case AppLifecycleState.resumed: { 
        Utils.log('<--- AppLifecycleState.resumed --->');
        // app moved to foreground (but not if just opened)
      } 
      break;       
      case AppLifecycleState.detached: { 
        Utils.log('<--- AppLifecycleState.detached --->');
      } 
      break; 
      case AppLifecycleState.inactive: { 
        Utils.log('<--- AppLifecycleState.inactive --->');
      } 
      break;       
      default: { 
        Utils.log('<--- AppLifecycleState.(unkown) --->');
      }
      break; 
    }     

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'HintPage',
      routes: {
        'HintPage': (context) => const HintPage(),
        'StartPage': (context) => const StartPage(),
        'EndPage': (context) => const EndPage(),
        'DebugPage': (context) => const DebugPage(),
      },
      //  see:
      //  https://sanjibsinha.com/color-flutter/
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Config.appButtonColor,                                     // from Config.dart 
          onPrimary: Config.appButtonTextColor,                               // from Config.dart
          brightness: Brightness.dark,
          onBackground: Colors.white,
          onError: Colors.yellow,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          background: Colors.yellow,
          secondary: Colors.purple,
          surface: Color(0xFF0A0E21),
          secondaryVariant: Colors.white,
          error: Colors.red,
          primaryVariant: Color(0xFF0A0E21),            
        ),
        scaffoldBackgroundColor: Config.appBackgroundColor,                   // from Config.dart    
        appBarTheme: const AppBarTheme(
          backgroundColor: Config.appBarColor,                                // from Config.dart  
          // This will control the "back" icon
          iconTheme: IconThemeData(color: Config.appBarTextColor ),         // from Config.dart
          // This will control action icon buttons that locates on the right
          actionsIconTheme: IconThemeData(color: Config.appBarTextColor ),  // from Config.dart
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            //fontWeight: FontWeight.bold,
            // fontFamily: 'Allison',
            color: Config.appBarTextColor,                                    // from Config.dart
          ),
        ),

        //  For textmodifiers see: 
        //  https://api.flutter.dev/flutter/material/TextTheme-class.html
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Config.appTextColor ),
        ),          
 
      ),
    );
  }
}
