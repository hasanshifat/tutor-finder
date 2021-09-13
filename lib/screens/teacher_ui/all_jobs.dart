import 'package:flutter/material.dart';
import 'package:tutor_finder/components/mytext.dart';

class AllJobs extends StatefulWidget {
  const AllJobs({Key key}) : super(key: key);

  @override
  _AllJobsState createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Mytext(text: 'All jobs'),
      ),
    );
  }
}
