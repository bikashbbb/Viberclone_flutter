import 'package:flutter/material.dart';
import 'package:flutter_projects/viber_clone/callsinterface.dart';
import 'package:flutter_projects/viber_clone/exploreui.dart';
import 'package:flutter_projects/viber_clone/homepage.dart';
import 'package:flutter_projects/viber_clone/screens/morepage.dart';

class MyColor {
  String my_hexcolor = '#665CAC';

  int into_intcolor() {
    String int_color_code = my_hexcolor.replaceAll('#', '0xff');
    return int.parse(int_color_code);
  }
}

class MyNavigator extends StatefulWidget {
  int number;
  MyNavigator(this.number);

  @override
  _MyNavigatorState createState() => _MyNavigatorState(number);
}

class _MyNavigatorState extends State<MyNavigator> {
  int icon_number;
  _MyNavigatorState(this.icon_number);
  Color iconcolor = Colors.black26;
  Color chnagedcolor = Color(MyColor().into_intcolor());

  void chatclicked(BuildContext context, var newpage, int field) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return newpage;
    }));
    setState(() {
      icon_number = field;
    });
  }

  Widget my_icons(
          {IconData icon_shape,
          String subtitle,
          @required BuildContext context,
          int field}) =>
      InkWell(
        onTap: () {
          if (field == 1) {
            chatclicked(context, ViberPage(), field);
          } else if (field == 2) {
            chatclicked(context, CallUi(), field);
          } else if (field == 3) {
            chatclicked(context, ExplorePage(), field);
          } else if (field == 4) {
            chatclicked(context, MorePage(), field);
          }
        },
        child: Container(
          width: 70,
          child: ListTile(
            title: Column(
              children: [
                Icon(
                  icon_shape,
                  color: (field == icon_number) ? chnagedcolor : iconcolor,
                  size: 32,
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                '$subtitle',
                style: TextStyle(
                    fontSize: 10,
                    color: (field == icon_number) ? chnagedcolor : iconcolor),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // height of appbar
    // todo : stack the message button on it maybe from the mainhome file ..
    return Stack(
      children: [
        Container(
          height: 57,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBar(
                backgroundColor: Colors.white,
                shadowColor: Colors.black,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    my_icons(
                        icon_shape: Icons.chat,
                        subtitle: 'Chats',
                        context: context,
                        field: 1),
                    //
                    my_icons(
                        icon_shape: Icons.call,
                        subtitle: 'Calls',
                        context: context,
                        field: 2),
                    my_icons(
                        icon_shape: Icons.explore,
                        subtitle: 'Explore',
                        context: context,
                        field: 3),
                    my_icons(
                        icon_shape: Icons.horizontal_split_outlined,
                        subtitle: 'More',
                        context: context,
                        field: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
