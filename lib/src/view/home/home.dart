import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:report_system/src/controllers/home_controller.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/app_theme.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/view/reports/report_form.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../models/report.dart';
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
    final reportController = ref.read(homeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);

    final homeController = ref.watch(homeProvider);
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
        body: StreamBuilder<QuerySnapshot>(
          stream: homeController.reportStream(),
          builder: (context, snapshot) {

           // if(snapshot.hasData) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);

            }
            if(snapshot.hasError){
              return Center(child:Text('Unable to load data'));
            }
            final data = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('REPORTS SUMMARY',
                              style: appTheme.textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,),),
                          ),
                          Gap(20),

                          Row(
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [
                              Gap(50),
                              CircleAvatar(
                                radius:75,
                                child: LiquidCircularProgressIndicator(
                                  value: data.length/100, // Defaults to 0.5.
                                  valueColor: AlwaysStoppedAnimation(Colors.black), // Defaults to the current Theme's accentColor.
                                  backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                                  borderColor: primaryColor,
                                  borderWidth: 5.0,
                                  direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                  center: Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Text('${data.length.toString()}',style: appTheme.textStyle.copyWith(color:Colors.black,fontSize: 9)),
                                      Gap(5),
                                      Text(' REPORTS SUBMITTED ',style: appTheme.textStyle.copyWith(color:Colors.black,fontSize: 9),),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(40),
                              Column(
                                children: [
                                  Text('${data.length.toString()}'),
                                  Gap(5),
                                  Text('Reports Submitted',style: appTheme.textStyle.copyWith(color:Colors.black,fontSize: 9)),
                                  Gap(12),
                                  Text('20'),
                                  Gap(5),
                                  Text('Reports In Review',style: appTheme.textStyle.copyWith(color:Colors.black,fontSize: 9)),
                                ],
                              ),

                              ],
                          ),


                        ],
                      ),
                      decoration: BoxDecoration(color: white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius
                              .circular(10), bottomRight: Radius.circular(10))),
                    ),

                    Gap(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Recents', style: appTheme.textStyle,),
                    ),
                    Gap(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final report=Reports.fromJson(data[index].data() as Map<String,dynamic>);
                            return ListTile(title: Text(report.report.toString()),subtitle: Text(
                                Jiffy(report.createdAt.toString()).format("MMMM do yyyy, h:mm:ss a")


                            ),trailing: Container(
                              child:Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(report.reportStatus.toString()),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),),);
                            //   Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Text('Report submitted',
                            //         style: appTheme.textStyle,),
                            //     ), Icon(Icons.report_outlined),
                            //   ],
                            // );
                          }
                      ),
                    ),


                  ],
                ),
              );



          }
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
