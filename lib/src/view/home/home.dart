import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/app_theme.dart';
import 'package:report_system/src/utils/colors.dart';
import 'package:report_system/src/view/reports/report_form.dart';


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
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, ReportForm.route);
            // showCupertinoModalBottomSheet(context: context, builder: (context){
            //   return Scaffold(
            //     body: Container(height:500, child: Column(children: [
            //       Center(child: Text('Report Form',))
            //     ],),),
            //   );
            // });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: const Text('Make a report'),decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(20)),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StatusCards(appTheme: appTheme),   Gap(10),
                    StatusCards(appTheme: appTheme),
                  ],
                ),
                Gap(10),
                Row(
                  children: [
                    StatusCards(appTheme: appTheme),   Gap(10),
                    StatusCards(appTheme: appTheme),
                  ],
                ),
                Gap(20),
                Text('Recents',style: appTheme.textStyle,),
                 Gap(20),
                 ListView.builder(
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


              ],
            ),
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
            Text('Total reports submitted  0',style: appTheme.textStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 17),),

          ],
        ),
        height:100,decoration: BoxDecoration(color:primaryColor,borderRadius: BorderRadius.circular(5)),),
    );
  }
}
