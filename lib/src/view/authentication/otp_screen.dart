import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/view/home/bottom_bar.dart';

import '../../utils/colors.dart';
import '../../utils/status.dart';




class OtpScreen extends ConsumerStatefulWidget {
  static const route = 'otpscreen';
  const OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {

  refreshAccount() async {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final signUpController = ref.watch(signUpProvider);
    final appProvider= ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0.0,leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        Navigator.pop(context);
      },),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Input the otp sent to your mobile number',style:appProvider.textStyle.copyWith(fontSize:15)),
          Gap(30),
          Center(
            child: OTPField(
              onChanged: signUpController.onOtpChange,
              onComplete: (e) {
                signUpController.verifyPhoneNumber(context: context);
              },
            ),

          ),
          Gap(30),
          ElevatedButton(
            onPressed: () async {
              await signUpController.signIn(
                  context: context, callBack: refreshAccount);

              // if its from sign up

              //user needs to accept the privacy policy

              // if (signUpController.otpStatus != Status.loading) {
              //   await signUpController.verifyPhoneNumber(
              //       context: context);
              // } else {
              //   showToast(signUpController.otpStatus);
              // }

              Navigator.pushNamed(context, BottomNavBar.route);


            },
            child:
            (
                signUpController.loginStatus != Status.loading
            )
                ?
            Text('Verify',
                style:appProvider.textStyle.copyWith(fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center)
                : const SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    //  color: AppTheme.white,
                  ),
                )),
            style: ElevatedButton.styleFrom(
                primary: primaryColor,

                minimumSize: Size(130, 55),
                maximumSize: Size(130, 55),
                fixedSize: Size(130, 55)),
          ),
        ],
      ),
    );
  }
}



class OTPField extends StatefulWidget {
  final Function? onChanged;
  final Function? onComplete;
  final TextEditingController? textEditingController;

  const OTPField(
      {Key? key, this.onChanged, this.onComplete, this.textEditingController})
      : super(key: key);

  @override
  _OTPFieldState createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  String? currentText;

  TextEditingController _textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? _errorController;

  @override
  void initState() {
    super.initState();
    _errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    _errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 270),
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        keyboardType: TextInputType.number,
        obscureText: false,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        animationType: AnimationType.fade,
        textStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 34,
          activeFillColor: Colors.white,
          inactiveColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColor,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        errorAnimationController: _errorController,
        controller: widget.textEditingController ?? _textEditingController,
        enableActiveFill: false,
        onCompleted: widget.onComplete as void Function(String)?,
        onChanged: widget.onChanged as void Function(String),
        beforeTextPaste: (text) {
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}
