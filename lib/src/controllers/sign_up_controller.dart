// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:report_system/src/utils/status.dart';
//
// import '../utils/error_codes.dart';
// import '../utils/reusable widgets.dart';
//
// class SignUpController extends ChangeNotifier{
//   Status otpStatus = Status.notStarted;
//   String phoneNumber = '';
//   String? countryCode;
//   String? verificationCode;
//   bool otpSent = false;
//
//
//   void smsOTPSent(String verId, [int? forceCodeResend]) async {
//     // await initSmsListener();
//     verificationCode = verId;
//     debugPrint("Verififcation Code");
//     debugPrint(verificationCode);
//
//     //_showOTPScreen();
//   }
//
//   Future<void> verifyPhoneNumber({required BuildContext context}) async {
//     print("verifying phone number");
//     print(phoneNumber);
//     print(countryCode);
//     String _phone = "$countryCode$phoneNumber";
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//
//     if (phoneNumber.length < 8 || phoneNumber.length > 10) {
//       showToast('Invalid phone No');
//     } else {
//       otpStatus = Status.loading;
//
//       try {
//         await _auth.verifyPhoneNumber(
//           phoneNumber: _phone.trim(),
//           codeAutoRetrievalTimeout: (String verId) {
//             verificationCode = verId;
//           },
//           codeSent: smsOTPSent,
//           timeout: const Duration(seconds: 60),
//           verificationCompleted:
//               (PhoneAuthCredential phoneAuthCredential) async {
//             UserCredential result =
//             await _auth.signInWithCredential(phoneAuthCredential);
//             FocusManager.instance.primaryFocus?.unfocus();
//             otpStatus = Status.success;
//             otpSent = true;
//           },
//           verificationFailed: (FirebaseAuthException exception) {
//             if (exception.code == 'invalid-phone-number') {
//               showToast('Invalid phone no !');
//               print('The provided phone number is not valid.');
//             } else {
//               showToast(ErrorCodes.getFirebaseErrorMessage(exception));
//             }
//             // AdminApi().addAuthError(exception.toString(), _phone);
//
//             otpStatus = Status.failed;
//           },
//         );
//       } on FirebaseAuthException catch (e) {
//         otpStatus = Status.failed;
//
//         showToast(ErrorCodes.getFirebaseErrorMessage(e));
//         // AdminApi().addAuthError(e.toString(), _phone);
//       } catch (e) {
//         otpStatus = Status.failed;
//
//         // AdminApi().addAuthError(e.toString(), _phone);
//       }
//     }
//   }
//
// }