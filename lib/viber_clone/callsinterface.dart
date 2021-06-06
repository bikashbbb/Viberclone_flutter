import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/viber_clone/APPBAR/myappbar.dart';
import 'package:flutter_projects/viber_clone/navigationbar.dart';

class CallUi extends StatefulWidget {
  @override
  _CallUiState createState() => _CallUiState();
}

class _CallUiState extends State<CallUi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEDF0F6),
        bottomNavigationBar: MyNavigator(2),
        body: CustomScrollView(
          slivers: [CustomBar()],
        ),
      ),
    );
  }
}
