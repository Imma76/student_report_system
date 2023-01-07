import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/app_theme.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/view/reports/report_form.dart';

import '../../utils/reusable widgets.dart';


class HomePage extends ConsumerStatefulWidget {
  static const route = '/home';
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
        floatingActionButton: GestureDetector(
          onTap: (){
           // Navigator.pushNamed(context, ReportForm.route);
            showCupertinoModalBottomSheet(context: context, builder: (context){

              return ReportForm();
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child:  Text('Make a report',style: appTheme.textStyle.copyWith(color:white),),decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(20)),),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('TOTAL REPORTS SUBMITTED',style: appTheme.textStyle.copyWith(fontWeight: FontWeight.bold,color: Colors.white,),),
                        Gap(20),
                        CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 5.0,

                          percent: 0.5,
                          center: new Text("100"),
                          progressColor: Colors.green,
                        ),
                      ],
                    ),
                //   CircleAvatar(
                //     radius:50,
                //     child: LiquidCircularProgressIndicator(
                //     value: 50, // Defaults to 0.5.
                //     valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                //     backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                //     borderColor: Colors.red,
                //     borderWidth: 5.0,
                //
                //     direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                //     center: Text("50",style: appTheme.textStyle.copyWith(color:Colors.black),),
                // ),
                //   ),
                  ],
                ),
                decoration: BoxDecoration(  color: primaryColor,borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10))),
              ),

              Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Recents',style: appTheme.textStyle,),
              ),
               Gap(20),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListView.builder(
                   itemCount: 10,shrinkWrap: true,
                   itemBuilder: (context,index) {
                     return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Report submitted', style: appTheme.textStyle,),
                          ),  Icon(Icons.report_outlined),
                        ],
                      );
                   }
                 ),
               ),


            ],
          ),
        ),
      ),
    );
  }
}

class StatusCards extends StatelessWidget {
  const StatusCards({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width:120,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total reports submitted  0',style: appTheme.textStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),

          ],
        ),
        height:100,decoration: BoxDecoration(color:primaryColor,borderRadius: BorderRadius.circular(5)),),
    );
  }
}
