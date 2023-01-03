import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/colors.dart';

import '../../utils/reusable widgets.dart';


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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Gap(30),
              Center(child: Text('Abuse Form',style: appTheme.textStyle,)),
              Gap(30),
              TextField(

                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                  focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                  hintText: 'Brief explanation of abuse',
                border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
              ),),
                Gap(10),
                Text('Attach photos',style: appTheme.textStyle),
                Gap(5),
                Container(height:50, width:50,child: Icon(Icons.add),color: Colors.grey,),
                Gap(10),
                Text('Attach videos',style: appTheme.textStyle),
                Gap(5),
                Container(height:50, width:50,child: Icon(Icons.add),color: Colors.grey,),
                Gap(10),
                Text('Attach audios',style: appTheme.textStyle),
                Gap(5),
                Container(height:50, width:50,child: Icon(Icons.add),color: Colors.grey,),
                Row(
                children: [
                  Text('Send report anonymously', style: appTheme.textStyle,),Spacer(),
                  Switch(value: reportController.isAnonymous, onChanged: (value){
                    reportController.changeReportVisibility(value);
                  }),
                ],
              ),
                Visibility(
                visible: !reportController.isAnonymous,
                child: Column(
                  children: [
                    TextFieldWidget(hintText: 'email',),
                    Gap(10),
                    TextFieldWidget(hintText: 'regNo',),
                    Gap(10),
                    TextFieldWidget(hintText: 'name',),
                    Gap(10),
                    TextFieldWidget(hintText: 'current level',),
                  ],
                ),
              ),
              Gap(30),
              FlatButton(onPressed: (){},
                color: primaryColor,
                height: 50,
                minWidth: double.infinity,
                child: Text('Submit',style: appTheme.textStyle.copyWith(color: Colors.white),), )


            ],),
          ),
        )
      ),
    );
  }
}
