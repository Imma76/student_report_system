import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_system/src/controllers/central_state.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/routes/routes.dart';
import 'package:report_system/src/servicees/push_notification_service.dart';
import 'package:report_system/src/view/home/bottom_bar.dart';
import 'package:report_system/src/view/home/home.dart';
import 'package:report_system/src/view/onboarding.dart';
import 'package:report_system/src/view/welcome_screen.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await PushNotificationService().setupInteractedMessage();
  centralState.initializeApp();
  runApp(const ProviderScope(child:  MyApp()));
}
// final CentralState centralState =CentralState();

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

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: routes,

      navigatorObservers: [BotToastNavigatorObserver()],

      title: 'Flutter Demo',
    //  theme: appThemeProvider.isDark? appThemeProvider.darkTheme:appThemeProvider.lightTheme,
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
            return HomePage();
          }else if (!centralProvider!.isFirstTime!){
            return WelcomePage();
          }else{
            return OnBoardingPage();
          }


  }
}
