// import 'package:bot_toast/bot_toast.dart';
//
// void showToast(message, {duration = const Duration(seconds: 3)}) =>
//     BotToast.showText(
//       text: message,
//       duration: duration,
//     );


import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? textController;
  const TextFieldWidget({
    Key? key,this.hintText,this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(decoration: InputDecoration(hintText: hintText),controller: textController,);
  }
}
