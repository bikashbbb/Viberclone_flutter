import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/viber_clone/chatscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_projects/firebase.dart';

// todo make a good format of list tile

class ChatBody extends StatefulWidget {
  Widget container({String username, double width = 55}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius:
            (width != 55) ? BorderRadius.all(Radius.circular(10)) : null,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: (username == 'My Notes')
              ? AssetImage('lib/assets/note.jpg')
              : AssetImage('lib/assets/nophoto.png'),
        ),
      ),
    );
  }

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  String email;
  String personalname;

  List datalist = [
    {'username': 'My Notes'}
  ];

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
        email = event.get('email');
      });
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('user');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List

    final alldatalist = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (Map individualmap in alldatalist) {
      if (individualmap['email'] != email) {
        datalist.add(individualmap);
      }
    }
    setState(() {
      datalist;
    });
  }

  Widget my_tile(int index, String username, String chatuserUID) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Container(
        height: 81,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Chatui(username, chatuserUID);
            }));
          },
          trailing: Column(
            children: [
              Icon(
                FontAwesomeIcons.checkDouble,
                size: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Transform.rotate(
                  angle: -225,
                  child: (index == 0)
                      ? Icon(
                          Icons.push_pin_outlined,
                          size: 15,
                        )
                      : null,
                ),
              ),
            ],
          ),
          tileColor: Colors.white60,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: InkWell(
                onTap: () {}, child: ChatBody().container(username: username)),
          ),
          title: Text(
            '$username',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: (username == 'My Notes')
              ? Text('Clone viber from today! oho complete with backedn also')
              : Text('Say hi to $username'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return my_tile(
          index, datalist[index]['username'], datalist[index]['uid']);
    }, childCount: datalist.length));
  }
}
