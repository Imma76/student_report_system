import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:report_system/src/providers/all_providers.dart';
import 'package:report_system/src/utils/colors.dart';


class Settings extends ConsumerStatefulWidget {
  static const route = '/settings';
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    final apptheme = ref.read(themeProvider);
    return Scaffold(

      //backgroundColor: Colors.red,
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //Center(child: CircleAvatar(radius: 50,)),
         // Gap(30),
          Container(
            height: 120,
            width: double.infinity,
            color:primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Settings',style:apptheme.textStyle.copyWith(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Gap(20),
              ],
            ),
          ),
          Gap(30),

          SettingsTab(settingIcon: Icons.person_outline,settingsName: 'Profile',appTheme: apptheme,),
          Gap(20),
          SettingsTab(settingIcon: Icons.settings_outlined, settingsName: 'Settings',appTheme: apptheme,),


        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  final String settingsName;
  final IconData settingIcon;
  final appTheme;
  const SettingsTab({
    Key? key,required this.settingIcon,required this.settingsName,this.appTheme
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(title: Text(settingsName), trailing: Icon(Icons.arrow_forward_ios_rounded),leading: Icon(settingIcon),);
  }
}
