import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_system/src/view/home/home.dart';
import 'package:report_system/src/view/settings/settings.dart';

import '../../utils/app_theme.dart';
import '../../utils/colors.dart';


class BottomNavBar extends ConsumerStatefulWidget {
  static const route = '/bottomavbar';
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int currentIndex = 0;
  List<Widget> widgetList = [
    HomePage(),
    Settings(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: widgetList[currentIndex],

      bottomNavigationBar:BottomNavigationBar(
        currentIndex: currentIndex,


        onTap: (index){
          setState(() {
            currentIndex= index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color:currentIndex == 0? primaryColor:Colors.grey),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings,color:currentIndex == 1? primaryColor:Colors.grey),label: '')
        ],
      ),
    ));
  }
}
