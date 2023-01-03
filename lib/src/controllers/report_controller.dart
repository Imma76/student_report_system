import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';


class ReportController extends ChangeNotifier{
  bool isAnonymous = false;
  changeReportVisibility(bool newValue){
    isAnonymous = newValue;
    notifyListeners();

  }
}