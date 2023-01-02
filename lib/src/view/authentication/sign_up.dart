import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/view/home/home.dart';

import '../../utils/reusable widgets.dart';
import '../../utils/status.dart';
import '../home/bottom_bar.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final UnderlineInputBorder border =  const UnderlineInputBorder(
    borderSide: BorderSide(
    //  color: AppTheme.lightBlack,
      width: 2,
    ),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  final signUpController = ref.read(signUpPovider);
  }
  @override
  Widget build(BuildContext context) {
   // final signUpController = ref.watch(signUpPovider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  shape: BoxShape.rectangle,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffF0F0F0), // shadow color
                        blurRadius: 2, // shadow radius
                        offset: Offset(2, 5), // shadow offset
                        spreadRadius:
                        0.1, // The amount the box should be inflated prior to applying the blur
                        blurStyle: BlurStyle.normal // set blur style
                    ),
                  ]),
              //  height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      //   shape: BoxShape.rectangle
                      // color: AppTheme.coolGrey,
                    ),
                    child: CountryCodePicker(
                      padding: const EdgeInsets.all(2),
                      onChanged: (val) {
                        // signInController.countryCode =
                        //     val.dialCode ?? '';
                      },
                      onInit: (val) {
                        // signInController.countryCode =
                        //     val?.dialCode ?? '';
                      },
                      countryFilter: [
                        'UA',
                        'NG',
                        'IN',
                        'US',
                      ],
                      initialSelection: 'UA',
                      favorite: const ['+380', 'Uk'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textStyle: const TextStyle(
                          color: Colors.black, fontSize: 20),
                      showFlag: true,
                    ),
                  ),
                  Container(
                      height: 28,
                     // color: AppTheme.divider2,
                      width: 1),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (val) {
                        //signInController.phoneNumber = val;
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        border: border,
                        //enabledBorder:  border,
                        focusedBorder: InputBorder.none,
                        hintText: '(123) 456 - 7890',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(50),
          ElevatedButton(
            onPressed: () async {
              Navigator.pushNamed(context, BottomNavBar.route);
              // if its from sign up
              // if (!signInController1.signinIn) {
              // user needs to accept the privacy policy

                // if (signUpController.otpStatus != Status.loading) {
                //   // await signUpController.verifyPhoneNumber(
                //   //     context: context);
                // } else {
                //   showToast(signUpController.otpStatus);
                // }

              // } else {
              //   // else just sign in
              //   if (signInController.otpStatus != Status.loading) {
              //     await signInController.verifyPhoneNumber(
              //         context: context);
              //   } else {
              //     showToast(tr(Keys.loading));
              //   }
              // }
            },
            child:
    //(
            //     signUpController.otpStatus != Status.loading
            // )
             //   ?
            Text('Enter',
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    ),
                textAlign: TextAlign.center),
                // : const SizedBox(
                // height: 20,
                // width: 20,
                // child: Center(
                //   child: CircularProgressIndicator(
                //     strokeWidth: 2,
                //   //  color: AppTheme.white,
                //   ),
                // )),
            style: ElevatedButton.styleFrom(
             //   primary: Theme.of(context).,
                minimumSize: Size(130, 55),
                maximumSize: Size(130, 55),
                fixedSize: Size(130, 55)),
          ),
        ],
      ),
    );
  }
}
