import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/firebase.dart';
import 'package:flutter_projects/signup page.dart';
import 'package:flutter_projects/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_projects/viber_clone/homepage.dart';

// todo : MAKE USER LOGGED IN  :

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var _fireauth = await FirebaseAuth.instance;

  if (_fireauth.currentUser == null) {
    runApp(MyApp());
  } else {
    runApp(ViberPage());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calculator',
      // theme: ThemeData(primaryColor: Colors.white),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // fireauth
  FirebaseAuth _fireauth = FirebaseAuth.instance;

  TextEditingController password = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  String password_hint_text = 'PASSWORD';
  Color password_hint_color = Colors.black26;

  void login_clicked() async {
    if (password.text.length < 8) {
      setState(() {
        password.clear();
        password_hint_text = 'PASSWORD MUST CONTAIN 8 CHARACTER';
        password_hint_color = Colors.red;
      });
    } else {
      try {
        await _fireauth.signInWithEmailAndPassword(
            email: email_controller.text, password: password.text);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViberPage();
        }));
      } catch (e) {
        setState(() {
          password.clear();
          password_hint_text = 'PASSWORD OR EMAIL INVALID';
          password_hint_color = Colors.red;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              height: 400,
              width: 350,
              left: 20,
              bottom: 230,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'Please sign in to continue',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    all_textfields(
                        name_of_field: 'EMAIL',
                        icon: Icon(Icons.mail_outline),
                        controller: email_controller,
                        color_of_hint: Colors.black26),
                    all_textfields(
                        name_of_field: password_hint_text,
                        icon: Icon(Icons.lock_outline),
                        controller: password,
                        color_of_hint: password_hint_color,
                        obsecuretext: true),
                    SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 150,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0)),
                                onPressed: () {
                                  login_clicked();
                                },
                                color: Colors.orangeAccent,
                                child: ListTile(
                                  title: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 30,
                left: 50,
                child: Row(
                  children: [
                    Text(
                      'Dont have an account?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    InkWell(
                      // TODO : MAKE A FUNCTION
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
                      },
                      child: Text('sign up',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
