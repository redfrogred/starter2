import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './providers/Controller.dart';
import './classes/Config.dart';
import './classes/Utils.dart';
import './pages/_AllPages.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // prevent turning phone (landscape not allowed, Son!)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _MyAppState() {
    Utils.log('<<< ( main.dart ) init version ${ Config.appVersion } >>>', 2, true );
  }

  // (this page) variables
  static const String _fileName = 'main.dart';
  double? _scale14;
  double? _scale24;
  double? _scale32;    
  double? _scale48;   

  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log('( $_fileName ) initState()');
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
    // init the app
    Provider.of<Controller>(context, listen: false).initApp();
    _scale14 = 14*Config.scaleModifier;
    _scale24 = 24*Config.scaleModifier;
    _scale32 = 32*Config.scaleModifier;      
    _scale48 = 48*Config.scaleModifier; 
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'StartPage',
      routes: {
        'StartPage': (context) => const StartPage(),
        'EndPage': (context) => const EndPage(),
        'DebugPage': (context) => const DebugPage(),
      },
      //  see:
      //  https://sanjibsinha.com/color-flutter/
      theme: ThemeData(
        colorScheme: const ColorScheme(
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
        appBarTheme: AppBarTheme(
          backgroundColor: Config.appBarColor,                                // from Config.dart  
          // This will control the "back" icon
          iconTheme: IconThemeData(color: Config.appBarTextColor, size: _scale48 ),         // from Config.dart
          // This will control action icon buttons that locates on the right
          actionsIconTheme: IconThemeData(color: Config.appBarTextColor, size: _scale48 ),  // from Config.dart
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            //fontWeight: FontWeight.bold,
            // fontFamily: 'Allison',
            color: Config.appBarTextColor,                                    // from Config.dart
            fontSize: _scale32,
          ),
        ),

        //  For textmodifiers see: 
        //  https://api.flutter.dev/flutter/material/TextTheme-class.html
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Config.appTextColor, fontSize: _scale32 ),
          button: TextStyle( fontSize: _scale32 ),
          headline6: TextStyle( fontSize: _scale32 ),
        ),          
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all<Color>(Config.colorButtons),
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return EdgeInsets.fromLTRB( _scale24!, _scale14!, _scale24!, _scale14! );
                }
                return EdgeInsets.fromLTRB( _scale24!, _scale14!, _scale24!, _scale14! );
              },
            ),                  
          ),
        ), 
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  void _init( context ) {
    Utils.log('message');
  }
    
  @override
  Widget build(BuildContext context) {
    _init(context);

    return Container();
  }
}