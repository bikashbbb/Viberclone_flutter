import 'package:flutter/material.dart';
import 'package:flutter_projects/viber_clone/navigationbar.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: MyNavigator(3),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leadingWidth: 100,
              backgroundColor: Colors.white,
              leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Viber',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
            )
          ],
        ),
      ),
    );
  }
}
