import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/view/authentication/sign_up.dart';



class WelcomePage extends StatelessWidget {
  static const route = 'welcome';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo2.png', width: 200,height: 70,),Gap(100),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, SignUp.route);
              },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,right:20),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color:primaryColor2,
                  child: Center(child: Text('Sign up', style: GoogleFonts.lora(color: white, fontWeight: FontWeight.bold, fontSize: 18),)),
                ),
              ),
            ),
            Gap(20),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, SignUp.route);
              },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0,right:20),
                child: Container(
                  height: 60,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color:white,
                    border:Border.all(color: primaryColor2)
                  ),
                  child: Center(child: Text('Sign in', style: GoogleFonts.lora(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
