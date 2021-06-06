import 'package:flutter_projects/firebase.dart';

userinfos(String uid,{String username, String email, String password}) {
  Map<String, String> signupinfo = {
    'username': username,
    'email': email,
    'password': password,
    'uid': uid,
  };
  usersetup(signupinfo);
}
