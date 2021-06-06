import 'package:flutter/material.dart';
import 'package:flutter_projects/firebase.dart';
import 'package:flutter_projects/signup_infos.dart';
import 'main.dart';
import 'package:flutter_projects/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  String create_ac = 'Create Account';
  Color account_c = Colors.black;

  // CONTROLLERS
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController passoword = TextEditingController();

  // name of the hint text :
  String hint_of_password = 'PASSWORD';
  String hint_of_username = 'USERNAME';
  String hint_of_email = 'EMAIL';
  String hint_of_confirm_pw = 'CONFIRM PASSOWORD';

  // color
  Color color_of_username = Colors.black26;
  Color color_of_email = Colors.black26;
  Color color_of_password = Colors.black26;
  Color color_of_confrimpw = Colors.black26;

  void signup_clicked() async {
    if (username.text == '') {
      setState(() {
        color_of_username = Colors.red;
        hint_of_username = 'THIS FIELD CANNT BE EMPTY';
      });
    }

    if (passoword.text == '') {
      setState(() {
        hint_of_password = 'THIS FIELD CANNT BE EMPTY';
        color_of_password = Colors.red;
      });
    }
    if (confirm_password.text == '') {
      setState(() {
        hint_of_confirm_pw = 'THIS FIELD CANNT BE EMPTY';
        color_of_confrimpw = Colors.red;
      });
    }
    if (confirm_password.text != passoword.text) {
      setState(() {
        hint_of_confirm_pw = 'password doesnt match'.toUpperCase();
        color_of_confrimpw = Colors.red;
      });
    }
    if (passoword.text.length < 8 && passoword.text != '') {
      setState(() {
        passoword.clear();
        hint_of_password = 'PASSWORD MUST CONTAIN 8 CHARACTER';
        color_of_password = Colors.red;
      });
    }
    if (email.text == '') {
      setState(() {
        hint_of_email = 'THIS FIELD CANNT BE EMPTY';
        color_of_email = Colors.red;
      });
    } else {
      if (!email.text.contains('.com') && email.text != '') {
        setState(() {
          email.clear();
          hint_of_email = 'INVALID EMAIL ID';
          color_of_email = Colors.red;
        });
      } else {
        try {
          FirebaseAuth firebaseauth = FirebaseAuth.instance;
          await firebaseauth.createUserWithEmailAndPassword(
              email: email.text, password: passoword.text);
          userinfos(uid,
              email: email.text,
              password: passoword.text,
              username: username.text);
          setState(() {
            create_ac = 'Account Created!';
            account_c = Colors.green;
          });
        } catch (e) {
          setState(() {
            email.clear();
            hint_of_email = 'EMAIL ALREADY REGISTERED';
            color_of_email = Colors.red;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.white,
          ),
          Positioned(
            height: 450,
            width: 350,
            left: 20,
            bottom: 280,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text(create_ac,
                        style: TextStyle(
                            color: account_c,
                            fontSize: 36,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  all_textfields(
                      name_of_field: hint_of_username,
                      icon: Icon(Icons.account_box_outlined),
                      controller: username,
                      color_of_hint: color_of_username),
                  SizedBox(
                    height: 15,
                  ),
                  all_textfields(
                      name_of_field: hint_of_email,
                      icon: Icon(Icons.email_outlined),
                      controller: email,
                      color_of_hint: color_of_email),
                  SizedBox(
                    height: 15,
                  ),
                  all_textfields(
                      name_of_field: hint_of_password,
                      icon: Icon(Icons.lock_outlined),
                      controller: passoword,
                      color_of_hint: color_of_password),
                  SizedBox(
                    height: 15,
                  ),
                  all_textfields(
                      name_of_field: hint_of_confirm_pw,
                      icon: Icon(Icons.lock_outlined),
                      controller: confirm_password,
                      color_of_hint: color_of_confrimpw),
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
                                signup_clicked();
                              },
                              color: Colors.orangeAccent,
                              child: ListTile(
                                title: Text(
                                  'SIGN UP',
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
                    'Already have a account?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  InkWell(
                    // TODO : MAKE A FUNCTION
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyApp();
                      }));
                    },
                    child: Text('sign in',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
