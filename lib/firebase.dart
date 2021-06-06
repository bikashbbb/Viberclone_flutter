import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebase_object = FirebaseAuth.instance;
final uid = firebase_object.currentUser.uid;
var firebase = FirebaseFirestore.instance;
// lets make it a fcking class
Future usersetup(Map userinfos) async {
  DocumentReference user =
      FirebaseFirestore.instance.collection('user').doc(uid);
  user.set(userinfos);
  return user;
}
