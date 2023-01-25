import 'package:flutter/material.dart';

import 'colors.dart';

Future showMyDialog(context,
    {Widget? child,
      EdgeInsets? contentPadding,
      bool isDismissible = false,
      double? width}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: isDismissible, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(10))),
        contentPadding: contentPadding ?? EdgeInsets.all(5),
        content: Container(width: width ?? 250, child: child),
      );
    },
  );
}
