// TODO : MAKE HOME PAGE SAME AS VIBER

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/viber_clone/APPBAR/myappbar.dart';
import 'package:flutter_projects/viber_clone/chat_scroll.dart';
import 'package:flutter_projects/viber_clone/navigationbar.dart';

class ViberPage extends StatefulWidget {

  Widget messegebox = Positioned(
    bottom: 10,
    right: 2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(MyColor().into_intcolor()),
                ),
                height: 60,
                width: 60,
                child: InkWell(
                  child: Icon(
                    Icons.message,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );

  @override
  _ViberPageState createState() => _ViberPageState();
}

class _ViberPageState extends State<ViberPage> {
  

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: MyNavigator(1),
          backgroundColor: Color(0xFFEDF0F6),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomScrollView(
                slivers: [
                  CustomBar(), // appbar
                  ChatBody(), // interface body
                ],
              ),
              ViberPage().messegebox
            ],
          )),
    );
  }
}
