import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/utils/loader.dart';

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
    final reportController = ref.read(homeProvider);
  }
  @override
  Widget build(BuildContext context) {

    final reportController = ref.watch(homeProvider);
    final imageController = ref.watch(imageProvider);
    return SafeArea(
      child:  Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Report Form',style:GoogleFonts.lora(color: Colors.black),),
            backgroundColor: Colors.transparent,elevation: 0,actions: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:Icon(Icons.close,color: Colors.black,))
          ],),

        body: reportController.load?const Indicator2(): Padding(
          padding: const EdgeInsets.only(left:12.0,right: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Gap(20),
              TextField(
                controller: reportController.abuseExplanationController,
                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: primaryColor2)),
                  focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: primaryColor2)),
                  hintText: 'Brief explanation of abuse',
                border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor2)),
              ),),
                Gap(10),
                Text('Attach photos',style: GoogleFonts.lora()),
                Gap(10),
                Row(
                  children: [
                    MediaPicker(onTap: (){
                      imageController.pickImage();
                    },),
                    Expanded(
                      child: Container(
                        height: 80,
                        child: ListView.builder(

                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: imageController.imageFiles.length,
                            itemBuilder: (context,index){
                              print( imageController.imageFiles);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      imageController.imageFiles.removeAt(index);
                                setState(() {

                                });
                                },
                                    child: Icon(Icons.cancel,size: 10,)),
                                Container(height: 50, width:50,child: Image.file( imageController.imageFiles[index]),),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Text('Attach videos',style: GoogleFonts.lora()),
                Gap(5),
                Row(
                  children: [
                    MediaPicker(onTap: (){
                      imageController.pickVideos();
                    },
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        child: ListView.builder(

                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:  imageController.videoFiles.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap:(){
                                          imageController.videoFiles.removeAt(index);
                                          setState(() {

                                          });
                                        },
                                        child: Icon(Icons.cancel,size: 10,)),
                                    Container(height: 50, width:50,child: Image.file( imageController.videoFiles[index]),),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Text('Attach audios',style: GoogleFonts.lora()),
                Gap(5),
                Row(
                  children: [
                    MediaPicker(onTap: (){
                      imageController.pickAudios();
                    },),
                    Expanded(
                      child: Container(
                        height: 80,
                        child: ListView.builder(

                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:  imageController.audioFiles.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap:(){
                                          imageController.audioFiles.removeAt(index);
                                          setState(() {

                                          });
                                        },
                                        child: Icon(Icons.cancel,size: 10,)),
                                    Container(height: 50, width:50,child: Image.file( imageController.audioFiles[index]),),
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
                  Text('Send report anonymously', style: GoogleFonts.lora(),),Spacer(),
                  Switch(value: reportController.isAnonymous, onChanged: (value){
                    reportController.changeReportVisibility(value);
                  },activeColor: primaryColor2,),
                ],
              ),
                Visibility(
                visible: !reportController.isAnonymous,
                child: Column(
                  children: [
                    TextFieldWidget(hintText: 'email',textController: reportController.emailController,),
                    Gap(10),
                    TextFieldWidget(hintText: 'regNo',textController: reportController.regNoController,),
                    Gap(10),
                    TextFieldWidget(hintText: 'name',textController: reportController.nameController,),
                    Gap(10),
                    TextFieldWidget(hintText: 'current level',textController: reportController.currentLevelController,),
                  ],
                ),
              ),
              Gap(30),
              ElevatedButton(onPressed: (){

                reportController.submitReport(imageController);
              },
                style: ElevatedButton.styleFrom(primary: primaryColor2,
                  fixedSize: const Size(double.infinity,50),
                 minimumSize:  const Size(double.infinity,50),
                 // minWidth: double.infinity,
                  ),
                child: Text('Submit',style: GoogleFonts.lora(color: Colors.white),), ),

                Gap(20),
            ],),
          ),
        )
      ),
    );
  }
}

