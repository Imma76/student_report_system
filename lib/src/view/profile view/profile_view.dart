import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProfileView extends ConsumerStatefulWidget {
  static const route = 'profileview';
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [

    ],),);
  }
}
