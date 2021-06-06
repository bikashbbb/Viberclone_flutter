import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/firebase.dart';
import 'package:flutter_projects/viber_clone/chat_scroll.dart';
import 'package:flutter_projects/viber_clone/navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// todo: complete production viber...

class Chatui extends StatefulWidget {
  String chatuserUid;
  String username;
  Chatui(this.username, this.chatuserUid);
  @override
  _ChatuiState createState() => _ChatuiState(username, chatuserUid);
}

class _ChatuiState extends State<Chatui> {
  String chatuserUid;
  String username;
  _ChatuiState(this.username, this.chatuserUid);
  TextEditingController messegecontroller = TextEditingController();

  IconData my_micicon = Icons.mic;
  IconData senticon = FontAwesomeIcons.arrowRight;
  bool isiconchanged = false;

  void sentmessge() async {
    // lets connect the messege to firebase
    Map<String, dynamic> messege = {
      'sentby': uid,
      'messege': messegecontroller.text,
      'time': DateTime.now(),
      'hour': DateTime.now().hour,
      'minutes': DateTime.now().minute
    };
    await FirebaseFirestore.instance
        .collection('chatshistory')
        .doc(chatid(uid, chatuserUid))
        .collection('chats')
        .add(messege);
    setState(() {
      messegecontroller.clear();
      isiconchanged = false;
    });
  }

  void miciconClicked() {
    print('ok');
  }

  String chatid(String currentuseruid, String chatuseruid) {
    if (currentuseruid[0].codeUnits[0] > chatuserUid[0].codeUnits[0]) {
      return '$currentuseruid$chatuserUid';
    } else {
      return '$chatuserUid$currentuseruid';
    }
  }

  Widget chat_textfield() {
    return TextField(
      onChanged: (text) {
        if (messegecontroller.text != '') {
          setState(() {
            isiconchanged = true;
          });
        } else if (messegecontroller.text == '') {
          setState(() {
            isiconchanged = false;
          });
        }
      },
      controller: messegecontroller,
      decoration: InputDecoration(
        hintText: 'Type a messege...',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget micicon() {
    return Positioned(
      right: 12,
      bottom: 28,
      child: InkWell(
        onTap: () {
          (isiconchanged) ? sentmessge() : miciconClicked();
          // to do when tapped on mic
        },
        child: Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Color(MyColor().into_intcolor()),
              shape: BoxShape.circle,
            ),
            child: Icon(
              (isiconchanged) ? senticon : my_micicon,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget chaticon(IconData myicon) {
    return Icon(
      myicon,
      color: Colors.black26,
      size: 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MyColor().into_intcolor())),
          backgroundColor: Colors.white,
          title: ListTile(
            title: Text(
              username.split(' ')[0],
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            subtitle: Text(
              'last seen ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.call),
                    Icon(Icons.video_call_sharp),
                    Icon(Icons.more_vert),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 650,
                child: StreamBuilder(
                    stream: firebase
                        .collection('chatshistory')
                        .doc(chatid(uid, chatuserUid))
                        .collection('chats')
                        .orderBy('time', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return texttile(
                                snapshot.data.docs[index]['messege'],
                                snapshot.data.docs[index]['sentby'],
                                (snapshot.data.docs[index]['hour']).toString(),
                                (snapshot.data.docs[index]['minutes']
                                    .toString()));
                          },
                          itemCount: (snapshot.data.docs.length != null)
                              ? snapshot.data.docs.length
                              : snapshot.data.docs.length,
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
              Divider(
                color: Colors.white,
                height: 35,
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      color: Colors.black26,
                      height: 1,
                    ),
                    Container(
                      height: 79,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 35,
                                width: 370,
                                child: chat_textfield(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child:
                                        chaticon(Icons.sticky_note_2_rounded),
                                  ),
                                  chaticon(Icons.photo_outlined),
                                  chaticon(Icons.camera_alt_outlined),
                                  chaticon(Icons.gif_rounded),
                                  chaticon(Icons.alarm_outlined),
                                  chaticon(Icons.more_horiz),
                                  Container(
                                    width: 35,
                                  )
                                ],
                              ),
                            ],
                          ),
                          micicon()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget texttile(String text, String sentby, String hour, String minutes) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        height: 30,
        alignment:
            (sentby == uid) ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Row(
          mainAxisAlignment:
              (sentby == uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            (sentby != uid)
                ? ChatBody().container(username: 'no', width: 25)
                : Container(),
            (sentby != uid)
                ? Container(
                    width: 7,
                  )
                : Container(),
            Container(
              decoration: BoxDecoration(
                  color:
                      (sentby == uid) ? Colors.lightBlue[100] : Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Text(
                      '$text ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '$hour:$minutes',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
