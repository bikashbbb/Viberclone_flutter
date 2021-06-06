import 'package:flutter/material.dart';
import 'package:flutter_projects/viber_clone/navigationbar.dart';

class CustomBar extends StatefulWidget {
  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  bool searchtap = false;

  void search_tap() {
    searchtap = true;
    setState(() {
      leading = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  searchtap = false;
                  setState(() {
                    leading = Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Viber',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)));
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.arrow_back,
                    size: 26.0,
                    color: Color(MyColor().into_intcolor()),
                  ),
                ),
              )),
        ],
      );
    });
  }

  Widget leading = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Viber',
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black)));
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: (searchtap)
          ? Container(
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
      shadowColor: Colors.black,
      elevation: 10,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 8, top: 0),
            child: InkWell(
              onTap: () {
                search_tap();
              },
              child: (searchtap)
                  ? Text('hi')
                  : Icon(
                      Icons.search_outlined,
                      color: Color(MyColor().into_intcolor()),
                      size: 30.0,
                    ),
            ))
      ],
      backgroundColor: Colors.white,
      leading: leading,
      leadingWidth: (searchtap) ? 50 : 100,
      floating: true,
    );
  }
}
