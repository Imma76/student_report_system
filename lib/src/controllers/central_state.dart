import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:report_system/main.dart';
import 'package:report_system/src/models/user.dart';
import 'package:report_system/src/view/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CentralState extends ChangeNotifier{
  User? user;
  UserModel? userModel;
  bool isUserPresent = false;
  bool isAppLoading=false;
  bool isPhoneVerified=false;
  bool? isFirstTime = true;

  void userData(UserModel newUserModel){
    userModel= newUserModel;
    notifyListeners();
  }


  void setFirstTime()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstTime", false);
  }

  getIsUserFirstTime()async{
    final prefs = await SharedPreferences.getInstance();

    isFirstTime = prefs.getBool("isFirstTime")?? true;
    notifyListeners();
  }


  void initializeApp()async{
    await getIsUserFirstTime();

    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        isAppLoading = true;
        user = firebaseUser;
        notifyListeners();
        print(user);
        isUserPresent = (user != null);
        print(isUserPresent);
        notifyListeners();

        if (isUserPresent) {
          isPhoneVerified =
          !(user!.phoneNumber == null || user!.phoneNumber == '');
          // add logs
          // Status _response = await AdminApi()
          //     .checkIfAdminIsLinkedToSalonPhone(user!.uid, user!.phoneNumber);

        //.  isAdminLinkedToSalon = (_response == Status.success);
        }
        isAppLoading = false;
      } else{
        debugPrint('user is null prod');
        isUserPresent = false;
        user = null;
        isAppLoading = false;
        notifyListeners();
      }

    });
  }
  void logOut()async{
    await  FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(navigatorKey!.currentContext!, OnBoardingPage.route, (route) => false);

  }
}


final CentralState centralState = CentralState();