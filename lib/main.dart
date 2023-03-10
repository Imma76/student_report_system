import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_system/src/controllers/central_state.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/routes/routes.dart';
import 'package:report_system/src/view/home/bottom_bar.dart';
import 'package:report_system/src/view/onboarding.dart';
import 'package:report_system/src/view/welcome_screen.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final CentralState centralState =CentralState();

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  centralState.initializeApp();
  runApp(const ProviderScope(child:  MyApp()));
}


final botToastBuilder = BotToastInit();
class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final appThemeProvider= ref.read(themeProvider);
  }
  @override
  Widget build(BuildContext context) {
    final appThemeProvider= ref.watch(themeProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: routes,

      navigatorObservers: [BotToastNavigatorObserver()],

      title: 'Flutter Demo',
      theme: appThemeProvider.isDark? appThemeProvider.darkTheme:appThemeProvider.lightTheme,
      home: NavigatorApp(),
        builder: BotToastInit(),

    );
  }
}

class NavigatorApp extends ConsumerStatefulWidget {
  static const route = 'navigator_app';
  const NavigatorApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NavigatorAppState();
}

class _NavigatorAppState extends ConsumerState<NavigatorApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final centralProvider= ref.read(centralStateProvider);
    centralProvider.initializeApp();
  }
  @override
  Widget build(BuildContext context) {
    final centralProvider= ref.watch(centralStateProvider);
    print('lll${centralProvider.isFirstTime}');

          if(centralProvider.isUserPresent){
            return BottomNavBar();
          }else if (!centralProvider!.isFirstTime!){
            return WelcomePage();
          }else{
            return OnBoardingPage();
          }


  }
}
