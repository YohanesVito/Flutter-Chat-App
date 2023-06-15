import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/contact_model.dart';
import '../providers/auth_provider.dart';

class FirebaseService {

  Future<bool> createUserWithEmailAndPassword(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String emailAddress = authProvider.email;
    String password = authProvider.password;

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Store user document in the Realtime Database
      DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child('users');

      Contact contact = Contact(
        id: FirebaseAuth.instance.currentUser!.uid,
        username: FirebaseAuth.instance.currentUser!.email!
            .substring(
            0, FirebaseAuth.instance.currentUser!.email!.indexOf('@')),
        email: FirebaseAuth.instance.currentUser!.email!,
        avatar: "null",
      );

      usersRef.child(credential.user!.uid).set(contact.toJson());

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print("GAGAL" + e.toString());
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String emailAddress = authProvider.email;
    String password = authProvider.password;

    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.logout();
    await FirebaseAuth.instance.signOut();
  }
}


