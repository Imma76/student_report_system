import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'hide ModalBottomSheet;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/utils/loader.dart';
import 'package:report_system/src/view/reports/report_form.dart';

import '../../models/report.dart';
import '../welcome_screen.dart';


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
       backgroundColor: Color(0xffE9EFF3),
        appBar: AppBar(
          leading: null,
          elevation: 0.0,backgroundColor: Colors.transparent,actions: [
          IconButton(icon:const Icon(Icons.logout,color: Colors.grey, ),onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const WelcomePage()), (route) => false);
          },),
        ],),
        floatingActionButton: GestureDetector(
          onTap: (){

           // Navigator.pushNamed(context, ReportForm.route);
            showCupertinoModalBottomSheet(context: context, builder: (context){

              return const ReportForm();
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),decoration: BoxDecoration(color: primaryColor2,borderRadius: BorderRadius.circular(20)),
            child:  Text('New report',style: GoogleFonts.lora(color:white),),),
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

            int reviewCount= 0;

            int resolvedCount=0;
            //    final report=Reports.fromJson(data[index].data() as Map<String,dynamic>);
            for(var docData in reports){


              if(docData.reportStatus
                  =='In Review'){
                reviewCount++;
              }

              if(docData.reportStatus=='Resolved'){
                resolvedCount++;
              }

            }
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
             const Gap(10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child
                              : Row(
                            // scrollDirection: Axis.horizontal,
                            // shrinkWrap: true,
                            children: [
                              Gap(10),
                              Container(
                                height: 150,
                                width:300,
                                padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),

                                decoration:
                                BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(3), boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 25,
                                    color: Color.fromARGB(14, 14, 14, 0),
                                  ),
                                ],),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Image.asset("assets/report3.png",height: 30,width: 30,),
                                    const Gap(10),
                                    const Text('Total Reports',),
                                    const Gap(5),
                                    Text(reports.length.toString(),),

                                  ],
                                ),
                              ),  const Gap(10),
                              Container(
                                height: 150,
                                width:300,
                                padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),

                                decoration:
                                BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(3), boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 25,
                                    color: Color.fromARGB(14, 14, 14, 0),
                                  ),
                                ],),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Image.asset("assets/report3.png",height: 30,width: 30,),
                                    const Gap(10),
                                    const Text('Reports In Review',),
                                    const Gap(5),
                                    Text('$reviewCount',),

                                  ],
                                ),
                              ),  const Gap(10),
                              Container(
                                height: 150,
                                width:300,
                                padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),

                                decoration:
                                BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(3), boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 25,
                                    color: Color.fromARGB(14, 14, 14, 0),
                                  ),
                                ],),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Image.asset("assets/report3.png",height: 30,width: 30,),
                                    const Gap(10),
                                    const Text('Resolved Reports',),
                                    const Gap(5),
                                    Text('$resolvedCount',),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),

                    const Gap(30),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount: reports.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: ()async{
                                  // await PushNotificationService.pushNotification(
                                  //   title: 'Hello',
                                  //   message: 'Hi',
                                  //   fcmToken: 'c1nsFF0chEKQt-r0IUyLYr:APA91bH_KvAGs9-tnlukijm2YOKW-l_LdpwmExsHhrDM3SrfqnftyDIroJku-q-4IqhWbWNdwRpBgZThbkbsa2zSHNiRJqwXqvGPvNjYutt777uceRvTaF8dFpDltydeBg3v-iftDCX5'
                                  //);
                                },
                                child: Container(
                                  height: 60,

                                  decoration:const BoxDecoration( color: Colors.white, boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 13),
                                      blurRadius: 25,
                                      color: Color.fromARGB(14, 14, 14, 0),
                                    ),
                                  ], ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(
                                              width:200,
                                              child: Text(reports[index].report!.trim().toString(),style: GoogleFonts.lora(

                                           ), overflow: TextOverflow.ellipsis,softWrap: true,),
                                            ),
                                            const Gap(10),
                                            Text(
                                                  Jiffy(reports[index].createdAt.toString()).format("MMMM do yyyy, h:mm:a")),
                                          ],
                                        ),
                                    const Spacer(),

                                    Container(
                                      width: 90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(5)),
                                      child:Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(child: Text(reports[index].reportStatus.toString())),
                                      ),),
                                      ],
                                    ),
                                  ),

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
