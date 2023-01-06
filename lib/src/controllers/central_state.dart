import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class CentralState extends ChangeNotifier{
  User? user;
  bool isUserPresent = false;
  bool isAppLoading=false;
  bool isPhoneVerified=false;

  void initializeApp(){
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        isAppLoading = true;
        user = firebaseUser;
        notifyListeners();
        isUserPresent = (user != null);
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
      } else
        debugPrint('user is null prod');
    });
  }
}