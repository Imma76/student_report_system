import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'hide ModalBottomSheet;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:report_system/src/controllers/home_controller.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/app_theme.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/utils/loader.dart';
import 'package:report_system/src/view/reports/report_form.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';

import '../../models/report.dart';
import '../../utils/report_status.dart';
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

    final homeController = ref.watch(homeProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(elevation: 0.0,backgroundColor: white,actions: [
          IconButton(icon:const Icon(Icons.logout,color: Colors.grey, ),onPressed: (){},),
        ],),
        floatingActionButton: GestureDetector(
          onTap: (){

           // Navigator.pushNamed(context, ReportForm.route);
            showCupertinoModalBottomSheet(context: context, builder: (context){

              return const ReportForm();
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(20)),
            child:  Text('Make a report',style: GoogleFonts.lora(color:white),),),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: homeController.reportStream(),
          builder: (context, snapshot) {
            int reportsInReview = 0;
            int reportsSubmitted= 0;
            int reportsResolved = 0;



           // if(snapshot.hasData) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Indicator2();

            }
            if(snapshot.hasError){
              return const Center(child:Text('Unable to load data'));
            }
            List<Reports> reports = snapshot.data!.docs.map((e)=>Reports.fromJson(e.data() as Map<String,dynamic>)).toList();
            // for(var  report in reports){
            //   if(report.reportStatus == ReportStatus.inReview){
            //     reportsInReview++;
            //   }
            //   if(report.reportStatus == ReportStatus.submitted){
            //
            //     reportsSubmitted++;
            //
            //   }
            //   if(report.reportStatus == ReportStatus.resolved){
            //
            //     reportsResolved++;
            //
            //   }
            //
            // }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Center(
                        //   child: Text('REPORTS SUMMARY',
                        //     style:GoogleFonts.lora(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black,),),
                        // ),
                        // const Gap(20),

                        Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [

                            Column(
                              children: [
                                SquarePercentIndicator(
                                  width:70,
                                  height: 70,
                                  startAngle: StartAngle.bottomRight,
                                  reverse: true,
                                  borderRadius: 12,
                                  shadowWidth: 1.5,
                                  progressWidth: 5,
                                  shadowColor: Colors.grey,
                                  progressColor: Colors.blue,
                                  progress: reportsSubmitted/100,
                                  child: Center(
                                      child: Text(
                                        "$reportsSubmitted",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      )),
                                ),
                                const Gap(10),
                                Text('reports submitted',style:GoogleFonts.lora())
                              ],
                            ),
                            Column(
                              children: [
                                SquarePercentIndicator(
                                  width:70,
                                  height: 70,
                                  startAngle: StartAngle.bottomRight,
                                  reverse: true,
                                  borderRadius: 12,
                                  shadowWidth: 1.5,
                                  progressWidth: 5,
                                  shadowColor: Colors.grey,
                                  progressColor: Colors.blue,
                                  progress: reportsInReview/100,
                                  child: Center(
                                      child: Text(
                                        "$reportsInReview",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      )),
                                ),
                                const Gap(10),
                                Text('under review',style:GoogleFonts.lora())
                              ],
                            ),
                            Column(
                              children: [
                                SquarePercentIndicator(
                                  width:70,
                                  height: 70,
                                  startAngle: StartAngle.bottomRight,
                                  reverse: true,
                                  borderRadius: 12,
                                  shadowWidth: 1.5,
                                  progressWidth: 5,
                                  shadowColor: Colors.grey,
                                  progressColor: primaryColor,
                                  progress: reportsResolved/100,
                                  child: Center(
                                      child: Text(
                                        "$reportsResolved",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      )),
                                ),
                                const Gap(10),
                                Text('resolved reports',style:GoogleFonts.lora())
                              ],
                            )
                            //const Gap(50),
                            // CircleAvatar(
                            //   radius:75,
                            //   child: LiquidCircularProgressIndicator(
                            //     value: data.length/100, // Defaults to 0.5.
                            //     valueColor: const AlwaysStoppedAnimation(Colors.black), // Defaults to the current Theme's accentColor.
                            //     backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                            //     borderColor: primaryColor,
                            //     borderWidth: 5.0,
                            //     direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            //     center: Column(
                            //       mainAxisAlignment:MainAxisAlignment.center,
                            //       children: [
                            //         Text('${data.length.toString()}',style:GoogleFonts.lora(color:Colors.black,fontSize: 9)),
                            //         const Gap(5),
                            //         Text(' REPORTS SUBMITTED ',style: GoogleFonts.lora(color:Colors.black,fontSize: 9),),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            //const Gap(40),
                            // Column(
                            //   children: [
                            //     Text('${data.length.toString()}'),
                            //     const Gap(5),
                            //     Text('Reports Submitted',style:GoogleFonts.lora(color:Colors.black,fontSize: 9)),
                            //     const Gap(12),
                            //     const Text('20'),
                            //     const Gap(5),
                            //     Text('Reports In Review',style: GoogleFonts.lora(color:Colors.black,fontSize: 9)),
                            //   ],
                            // ),

                            ],
                        ),


                      ],
                    ),

                    Gap(30),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount: reports.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
print(reports[index].report!.trim().toString());
                            return Container(
                              height: 60,
                              color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                       Text(reports[index].report!.trim().toString()),
                                        Gap(10),
                                        Text(
                                              Jiffy(reports[index].createdAt.toString()).format("MMMM do yyyy, h:mm:a")),
                                      ],
                                    ),
                                Spacer(),

                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5)),
                                  child:Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(reports[index].reportStatus.toString()),
                                  ),),
                                  ],
                                ),
                              ),

                            );

                            //   ListTile(title: Text(report.report.toString()),subtitle: Text(
                            //     Jiffy(report.createdAt.toString()).format("MMMM do yyyy, h:mm:ss a")
                            //
                            //
                            // ),trailing: Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey,
                            //     borderRadius: BorderRadius.circular(5)),
                            //   child:Padding(
                            //     padding: const EdgeInsets.all(5.0),
                            //     child: Text(report.reportStatus.toString()),
                            //   ),),);
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
//
// class StatusCards extends StatelessWidget {
//   const StatusCards({
//     Key? key,
//     required this.appTheme,
//   }) : super(key: key);
//
//   final AppTheme appTheme;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width:120,
//         padding: const EdgeInsets.all(10),
//         height:100,decoration: BoxDecoration(color:primaryColor,borderRadius: BorderRadius.circular(5)),
//         child: Column(
//          // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Total reports submitted  0',style: GoogleFonts.lora(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),
//
//           ],
//         ),),
//     );
//   }
// }
