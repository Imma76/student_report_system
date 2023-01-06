import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
                            Gap(10),
                            Row(
                              children: [
                                MediaPicker(onTap: (){
                                  reportController.pickImage();
                                },),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    child: ListView.builder(

                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: reportController.imageFiles.length,
                                        itemBuilder: (context,index){
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      reportController.imageFiles.removeAt(index);
                                                      setState(() {

                                                      });
                                                    },
                                                    child: Icon(Icons.cancel,size: 10,)),
                                                Container(height: 50, width:50,child: Image.file(reportController.imageFiles[index]),),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Gap(10),
                            Text('Attach videos',style: appTheme.textStyle),
                            Gap(5),
                            Row(
                              children: [
                                MediaPicker(onTap: (){
                                  reportController.pickVideos();
                                },
                                ),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    child: ListView.builder(

                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: reportController.videoFiles.length,
                                        itemBuilder: (context,index){
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      reportController.videoFiles.removeAt(index);
                                                      setState(() {

                                                      });
                                                    },
                                                    child: Icon(Icons.cancel,size: 10,)),
                                                Container(height: 50, width:50,child: Image.file(reportController.videoFiles[index]),),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Gap(10),
                            Text('Attach audios',style: appTheme.textStyle),
                            Gap(5),
                            Row(
                              children: [
                                MediaPicker(onTap: (){
                                  reportController.pickAudios();
                                },),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    child: ListView.builder(

                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: reportController.audioFiles.length,
                                        itemBuilder: (context,index){
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      reportController.audioFiles.removeAt(index);
                                                      setState(() {

                                                      });
                                                    },
                                                    child: Icon(Icons.cancel,size: 10,)),
                                                Container(height: 50, width:50,child: Image.file(reportController.audioFiles[index]),),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
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
                              child: Text('Submit',style: appTheme.textStyle.copyWith(color: Colors.white),), ),

                            Gap(20),
                          ],),
                      ),
                    )
                ),
              );
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
                
                decoration: BoxDecoration(  color: primaryColor,borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10))),
              ),
              // Row(
              //   children: [
              //     StatusCards(appTheme: appTheme),   Gap(10),
              //     StatusCards(appTheme: appTheme),
              //   ],
              // ),
              // Gap(10),
              // Row(
              //   children: [
              //     StatusCards(appTheme: appTheme),   Gap(10),
              //     StatusCards(appTheme: appTheme),
              //   ],
              // ),
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
