

import 'package:flutter/cupertino.dart';
import 'package:report_system/src/view/authentication/otp_screen.dart';
import 'package:report_system/src/view/authentication/sign_up.dart';
import 'package:report_system/src/view/home/bottom_bar.dart';
import 'package:report_system/src/view/home/home.dart';
import 'package:report_system/src/view/onboarding.dart';
import 'package:report_system/src/view/reports/report_form.dart';
import 'package:report_system/src/view/settings/settings.dart';

Map<String,WidgetBuilder> routes ={
  HomePage.route:(BuildContext context)=>const HomePage(),
  BottomNavBar.route:(BuildContext context)=>const BottomNavBar(),
  Settings.route:(BuildContext context)=> const Settings(),
  ReportForm.route:(BuildContext context)=> ReportForm(),
  OtpScreen.route:(BuildContext context)=>OtpScreen(),
  SignUp.route:(BuildContext context)=> SignUp(),
  OnBoardingPage.route:(BuildContext context)=> OnBoardingPage()
};