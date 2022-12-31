import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      bottomNavigationBar:BottomNavigationBar(
        currentIndex: currentIndex,
        items: [

        ],
      ),
    ));
  }
}
