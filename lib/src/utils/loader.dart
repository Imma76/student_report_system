

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'colors.dart';


// class Indicator extends StatelessWidget {
//   final Color? color;
//   const Indicator({Key? key,this.color}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: SizedBox(
//       height: 30,
//       child: CircularProgressIndicator(color: color,strokeWidth:
//         3,),
//     ));
//   }
// }
//

class Indicator2 extends StatelessWidget {
  final Color? color;
  const Indicator2({Key? key,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(
        child:SpinKitDoubleBounce(color: primaryColor,)
    ));
  }
}

