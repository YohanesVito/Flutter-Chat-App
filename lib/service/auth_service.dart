import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/contact_model.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    //send user to Realtime Database
    DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');

    Contact contact = Contact(
      id: FirebaseAuth.instance.currentUser!.uid,
      username: FirebaseAuth.instance.currentUser!.displayName!,
      email: FirebaseAuth.instance.currentUser!.email!,
      avatar: FirebaseAuth.instance.currentUser!.photoURL!,
    );

    usersRef.child(FirebaseAuth.instance.currentUser!.uid).set(
        contact.toJson()
    );

  }
}