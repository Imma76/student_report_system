// import 'package:bot_toast/bot_toast.dart';
//
// void showToast(message, {duration = const Duration(seconds: 3)}) =>
//     BotToast.showText(
//       text: message,
//       duration: duration,
//     );


import 'package:flutter/material.dart';

import 'colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? textController;
  const TextFieldWidget({
    Key? key,this.hintText,this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(

      decoration: InputDecoration(hintText: hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            //  when the TextFormField in unfocused
          ) ,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            //  when the TextFormField in focused
          ) ,
          border: UnderlineInputBorder(
          )

     // enabledBorder: OutlineInputBorder(
     //
     //     //borderSide: BorderSide( color: primaryColor)
     // )
     // focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
    ),
      controller: textController,);
  }
}
