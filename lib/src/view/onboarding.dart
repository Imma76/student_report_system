import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:report_system/src/controllers/central_state.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/view/authentication/sign_up.dart';


class OnBoardingPage extends ConsumerStatefulWidget {
  static const route = 'onboarding';
  const OnBoardingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context, CentralState centralState) {
    centralState.setFirstTime();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignUp()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return ClipRRect(child: Image.asset('assets/$assetName', width: 600,height: 200,fit:BoxFit.fitWidth),borderRadius: BorderRadius.circular(10),);
  }

  @override
  Widget build(BuildContext context) {
    final centralProvvider = ref.watch(centralStateProvider);
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration =  PageDecoration(
      titleTextStyle: GoogleFonts.dmSans(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500),
      bodyTextStyle:GoogleFonts.dmSans(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      //pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,

      //globalBackgroundColor: Colors.whit,
      autoScrollDuration: null,

      pages: [
        PageViewModel(
          title: "",
          body:
          "Have you ever been abused while in school?",
          image: _buildImage('bully1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
          "Are you scared to report it to the school management?",
          image: _buildImage('bully2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
          "Sign up to report every forms of abuse to the school management either anonymously or not",
          image: _buildImage('bully3.jpg'),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context, centralProvvider),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back:  Icon(Icons.arrow_back,color: primaryColor2),
      skip:  Text('Skip', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
      next: Icon(Icons.arrow_forward,color: primaryColor2),
      done:  Text('Done', style:GoogleFonts.dmSans(

          fontSize: 16,
          fontWeight: FontWeight.w400,color: primaryColor2)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor:  primaryColor2,
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        // color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
//
// class OnBoardingPage extends StatefulWidget {
//   static const route = 'onboarding';
//   @override
//   _OnBoardingPageState createState() => _OnBoardingPageState();
// }
//
// class _OnBoardingPageState extends State<OnBoardingPage> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//
//   void _onIntroEnd(context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => SignUp()),
//     );
//   }
//
//   Widget _buildFullscreenImage() {
//     return Image.asset(
//       'assets/fullscreen.jpg',
//       fit: BoxFit.cover,
//       height: double.infinity,
//       width: double.infinity,
//       alignment: Alignment.center,
//     );
//   }
//
//   Widget _buildImage(String assetName, [double width = 350]) {
//     return ClipRRect(child: Image.asset('assets/$assetName', width: 600,height: 200,fit:BoxFit.fitWidth),borderRadius: BorderRadius.circular(10),);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 19.0);
//
//     const pageDecoration = const PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       //pageColor: Colors.white,
//       imagePadding: EdgeInsets.zero,
//     );
//
//     return IntroductionScreen(
//       key: introKey,
//       //globalBackgroundColor: Colors.whit,
//       autoScrollDuration: 3000,
//       // globalHeader: Align(
//       //   alignment: Alignment.topRight,
//       //   child: SafeArea(
//       //     child: Padding(
//       //       padding: const EdgeInsets.only(top: 16, right: 16),
//       //       child: _buildImage('flutter.png', 100),
//       //     ),
//       //   ),
//       // ),
//       // globalFooter: SizedBox(
//       //   width: double.infinity,
//       //   height: 60,
//       //   child: ElevatedButton(
//       //     child: const Text(
//       //       'Let\'s go right away!',
//       //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//       //     ),
//       //     onPressed: () => _onIntroEnd(context),
//       //   ),
//       // ),
//       pages: [
//         PageViewModel(
//           title: "",
//           body:
//           "Have you ever been abused while in school?",
//           image: _buildImage('image1.jpeg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "",
//           body:
//           "Are you scared to report it to the school management?",
//           image: _buildImage('image2.jpeg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "",
//           body:
//           "Sign up to report every forms of abuse to the school management either anonymously or not",
//           image: _buildImage('image3.jpeg'),
//           decoration: pageDecoration,
//         ),
//         // PageViewModel(
//         //   title: "Full Screen Page",
//         //   body:
//         //   "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
//         //   image: _buildFullscreenImage(),
//         //   decoration: pageDecoration.copyWith(
//         //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
//         //     fullScreen: true,
//         //     bodyFlex: 2,
//         //     imageFlex: 3,
//         //   ),
//         // ),
//         // PageViewModel(
//         //   title: "Another title page",
//         //   body: "Another beautiful body text for this example onboarding",
//         //   image: _buildImage('img2.jpg'),
//         //   footer: ElevatedButton(
//         //     onPressed: () {
//         //       introKey.currentState?.animateScroll(0);
//         //     },
//         //     child: const Text(
//         //       'FooButton',
//         //       style: TextStyle(color: Colors.white),
//         //     ),
//         //     style: ElevatedButton.styleFrom(
//         //       primary: Colors.lightBlue,
//         //       shape: RoundedRectangleBorder(
//         //         borderRadius: BorderRadius.circular(8.0),
//         //       ),
//         //     ),
//         //   ),
//         //   decoration: pageDecoration,
//         // ),
//         // PageViewModel(
//         //   title: "Title of last page - reversed",
//         //   bodyWidget: Row(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     children: const [
//         //       Text("Click on ", style: bodyStyle),
//         //       Icon(Icons.edit),
//         //       Text(" to edit a post", style: bodyStyle),
//         //     ],
//         //   ),
//         //   decoration: pageDecoration.copyWith(
//         //     bodyFlex: 2,
//         //     imageFlex: 4,
//         //     bodyAlignment: Alignment.bottomCenter,
//         //     imageAlignment: Alignment.topCenter,
//         //   ),
//         //   image: _buildImage('img1.jpg'),
//         //   reverse: true,
//         // ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//       showSkipButton: false,
//       skipOrBackFlex: 0,
//       nextFlex: 0,
//       showBackButton: true,
//       //rtl: true, // Display as right-to-left
//       back: const Icon(Icons.arrow_back),
//       skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: kIsWeb
//           ? const EdgeInsets.all(12.0)
//           : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       dotsContainerDecorator: const ShapeDecoration(
//        // color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//       ),
//     );
//   }
// }
//
