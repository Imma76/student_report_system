//
import 'package:flutter/material.dart';
 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_system/src/controllers/central_state.dart';
import 'package:report_system/src/controllers/report_controller.dart';
 import 'package:report_system/src/controllers/sign_up_controller.dart';
//
 import '../controllers/home_controller.dart';
import '../utils/app_theme.dart';
//
 final themeProvider= ChangeNotifierProvider<AppTheme>((ref)=>AppTheme());
 final reportProvider = ChangeNotifierProvider<ReportController>((ref) => ReportController());
 final signUpPovider = ChangeNotifierProvider<SignUpController>((ref) => SignUpController());
 final centralStateProvider= ChangeNotifierProvider<CentralState>((ref) => CentralState());
 final homeProvider = ChangeNotifierProvider<HomeController>((ref) => HomeController());