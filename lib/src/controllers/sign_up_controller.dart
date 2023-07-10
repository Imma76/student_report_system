import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_system/src/controllers/user_controller.dart';
import 'package:report_system/src/models/user.dart';
import 'package:report_system/src/servicees/user_service.dart';
import 'package:report_system/src/utils/status.dart';
import 'package:report_system/src/view/authentication/sign_up.dart';
import 'package:report_system/src/view/home/bottom_bar.dart';
import 'package:report_system/src/view/home/home.dart';

import '../../main.dart';
import '../utils/error_codes.dart';
import '../utils/reusable widgets.dart';
import '../view/authentication/otp_screen.dart';

final userService = UserService();
class SignUpController extends ChangeNotifier{
  Status otpStatus = Status.notStarted;
  // final userController= UserController();

  String phoneNumber = '';
  User? user;
  Status loginStatus = Status.notStarted;
  String? countryCode;
  bool userLoggedIn = false;
  String? verificationCode;
  bool otpSent = false;
  String otp='';

  void onOtpChange(val){
    otp = val;
    notifyListeners();
  }

  void smsOTPSent(String verId, [int? forceCodeResend]) async {
    // await initSmsListener();
    verificationCode = verId;
    debugPrint("Verififcation Code");
    debugPrint(verificationCode);
    otpStatus = Status.success;
    otpSent = true;
    notifyListeners();
    //Navigator.pushNamed(context, OtpScreen.route);

    //_showOTPScreen();
  }

  Future<void> verifyPhoneNumber({required BuildContext context}) async {
    print("verifying phone number");
    print(phoneNumber);
    print(countryCode);
    String _phone = "$countryCode$phoneNumber";
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (phoneNumber.length < 8 || phoneNumber.length > 10) {

      showToast('Invalid phone No');
      return;
    } else {
      otpStatus = Status.loading;
      notifyListeners();

      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: _phone.trim(),
          codeAutoRetrievalTimeout: (String verId) {
            verificationCode = verId;
            otpStatus = Status.failed;
            notifyListeners();
          },
          codeSent: (String verId, [int? forceCodeResend]) async {
            // await initSmsListener();
            verificationCode = verId;
            debugPrint("Verififcation Code");
            debugPrint(verificationCode);
            otpStatus = Status.success;
            otpSent = true;
            notifyListeners();
            Navigator.pushNamed(context, OtpScreen.route);

            //_showOTPScreen();
          },
          timeout: const Duration(seconds: 60),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            UserCredential result =
            await _auth.signInWithCredential(phoneAuthCredential);
            FocusManager.instance.primaryFocus?.unfocus();
            otpStatus = Status.success;
            otpSent = true;
            notifyListeners();
          },
          verificationFailed: (FirebaseAuthException exception) {
            otpStatus = Status.failed;
            notifyListeners();
            if (exception.code == 'invalid-phone-number') {
              showToast('Invalid phone no !');
              print('The provided phone number is not valid.');
            } else {
              print(exception.message);
              showToast(ErrorCodes.getFirebaseErrorMessage(exception));
            }
            // AdminApi().addAuthError(exception.toString(), _phone);

            otpStatus = Status.failed;
            notifyListeners();
          },
        );
      } on FirebaseAuthException catch (e) {
        otpStatus = Status.failed;
        notifyListeners();

        showToast(ErrorCodes.getFirebaseErrorMessage(e));
        // AdminApi().addAuthError(e.toString(), _phone);
      } catch (e) {
        print('heyyyy${e.toString()}');
        otpStatus = Status.failed;
        notifyListeners();

        // AdminApi().addAuthError(e.toString(), _phone);
      }
    }
  }

  static Future _onSignInCompletedPhoneVerif(User user,
      {bool byPassEmailVerification = false}) async {
    //by pass this check and then run the app

    if (user.phoneNumber == null || user.phoneNumber == '') {
      navigatorKey.currentState!.pushNamed(SignUp.route);
    } else {
      final check = await userService.checkIfUserExists(user.phoneNumber.toString());
      if(check){
        navigatorKey.currentState!.pushNamed(HomePage.route);
      }else{
        UserModel userModel = UserModel(regNo: '',email: '',mobile: user.phoneNumber,userId: user.uid);
        await userService.createUser(userModel);
        navigatorKey.currentState!.pushNamed(HomePage.route);
      }
    }
    // }
  }
  Future<Status> signIn(
      {required BuildContext context, required callBack}) async {
    try {
      loginStatus = Status.loading;
notifyListeners();
      UserCredential? _userResult;

      debugPrint("Verififcation Code");
      debugPrint(verificationCode);

      final PhoneAuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode!,
        smsCode: otp,
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      // debugPrint('v')

      _userResult = await _auth.signInWithCredential(_authCredential);

      // final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //         verificationId: verificationCode.toString(), smsCode: otp);

      if (_userResult.user != null) {
        await callBack();
        userLoggedIn = true;
        loginStatus = Status.success;
        user = _userResult.user;
        notifyListeners();
        //success
        showToast('signed in successfully');
        debugPrint(user!.uid);
        _onSignInCompletedPhoneVerif(user!);
      } else {
        loginStatus = Status.failed;
        notifyListeners();
        showToast('error occurred');
      }

     // _timer!.cancel();
    } on FirebaseAuthException catch (e) {

      loginStatus = Status.failed;
      notifyListeners();

      String? error = ErrorCodes.getFirebaseErrorMessage(e);
      if (error != null) {
        if (error == "invalid-verification-code") {
          showToast('Invalid OTP');
        } else {
          // if (locale != null && locale != 'en') {
          //   printIt(locale);
          //   var translatederror = await translator.translate(
          //       ErrorCodes.getFirebaseErrorMessage(e)!,
          //       from: 'en',
          //       to: locale);
          //   printIt(translatederror);
          //   showToast(translatederror);
          // } else {
          //   showToast(ErrorCodes.getFirebaseErrorMessage(e));
          // }
        }
      }
    } catch (e) {
      loginStatus = Status.failed;
      notifyListeners();
    }
    return loginStatus;
  }

}

