import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_projects/firebase.dart';
import 'package:flutter_projects/viber_clone/navigationbar.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String username = '';
  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .snapshots()
        .listen((event) {
      setState(() {
        username = event.get('username');
      });
    });
  }

  Widget mytile(IconData my_icon, Color color,
      {String title, String mysubtitle = ''}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 3),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(
            my_icon,
            color: Colors.white,
          ),
        ),
        title: Text('$title'),
        subtitle: (mysubtitle != '') ? Text('$mysubtitle') : null,
      ),
    );
  }

  Widget my_body() {
    return NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, index) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 200,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(50.0)),
                                height: 110,
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.all(45.0),
                                  child: Text(
                                   (username != '')?username[0].toUpperCase():username ,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          '$username',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      Text(
                        '+9779823219656',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 8),
                      ),
                    ],
                  )),
            ),
          ];
        },
        body: Column(
          children: [
            mytile(Icons.sports_cricket_sharp, Colors.orange[800],
                title: 'Sticker Marker'),
            mytile(Icons.add_ic_call_outlined, Colors.green[700],
                title: 'Viber Out',
                mysubtitle:
                    'Call home or abroad with Viber Out low calling rates'),
            mytile(Icons.group_add_outlined, Colors.orange[800],
                title: 'Start a group chat',
                mysubtitle: 'with friends and family'),
            mytile(Icons.settings, Colors.cyan[700], title: 'Settings'),
            mytile(Icons.notes, Color(MyColor().into_intcolor()),
                title: 'My Notes'),
            mytile(Icons.perm_contact_calendar_outlined, Colors.green[700],
                title: 'Add contact'),
            mytile(Icons.share, Color(MyColor().into_intcolor()),
                title: 'Invite friends'),
            mytile(Icons.error, Colors.orange[800], title: 'About and FAQ'),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: MyNavigator(4),
          body: my_body()),
    );
  }
}
