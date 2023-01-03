import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/routes/routes.dart';
import 'package:report_system/src/view/onboarding.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      debugShowCheckedModeBanner: false,
      routes: routes,

      title: 'Flutter Demo',
      theme: appThemeProvider.isDark? appThemeProvider.darkTheme:appThemeProvider.lightTheme,
      home:  OnBoardingPage(),
    );
  }
}

