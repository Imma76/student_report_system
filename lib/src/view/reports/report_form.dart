import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:report_system/src/providers/all_providers.dart';


class ReportForm extends ConsumerStatefulWidget {
  static const route = 'report_form';
  const ReportForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ReportFormState();
}

class _ReportFormState extends ConsumerState<ReportForm> {
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.read(themeProvider);
    return SafeArea(
      child: Scaffold(

        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Gap(30),
            Center(child: Text('Abuse Form',style: appTheme.textStyle,)),
            Gap(30),
            TextField(

              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Brief explanation of abuse',
              border: OutlineInputBorder(borderSide: BorderSide()),
            ),),
            Row(
              children: [
                Text('Submit anonymously'),Spacer(),
                Switch(value: true, onChanged: (value){}),
              ],
            )
          ],),
        )
      ),
    );
  }
}
