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
  void initState() {
    // TODO: implement initState
    super.initState();
    final reportController = ref.read(reportProvider);
  }
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);
    final reportController = ref.watch(reportProvider);
    return SafeArea(
      child: Scaffold(

        body:Padding(
          padding: const EdgeInsets.only(left:12.0,right: 12),
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
                Text('Send report anonymously', style: appTheme.textStyle,),Spacer(),
                Switch(value: reportController.isAnonymous, onChanged: (value){
                  reportController.changeReportVisibility(value);
                }),
              ],
            ),
            Visibility(
              visible: reportController.isAnonymous,
              child: Column(
                children: [
                  TextFieldWidget(hintText: 'email',),
                  TextFieldWidget(hintText: 'regNo',),
                  TextFieldWidget(hintText: 'name',),
                  TextFieldWidget(hintText: 'current level',),
                ],
              ),
            ),


          ],),
        )
      ),
    );
  }
}

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
