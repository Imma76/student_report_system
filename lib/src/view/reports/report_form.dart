import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


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
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(children: [
        Center(child: Text('Report Form',))
      ],)
    );
  }
}
