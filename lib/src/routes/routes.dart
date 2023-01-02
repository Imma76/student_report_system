

import 'package:flutter/cupertino.dart';
import 'package:report_system/src/view/home/bottom_bar.dart';
import 'package:report_system/src/view/home/home.dart';
import 'package:report_system/src/view/settings/settings.dart';

Map<String,WidgetBuilder> routes ={
  HomePage.route:(BuildContext context)=>const HomePage(),
  BottomNavBar.route:(BuildContext context)=>const BottomNavBar(),
  Settings.route:(BuildContext context)=> const Settings(),
};