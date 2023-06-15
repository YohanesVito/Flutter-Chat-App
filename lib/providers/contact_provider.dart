import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contacts = [];

  ContactProvider() {
    fetchContacts(); // Fetch contacts when the ContactProvider is initialized
  }

  Future<void> fetchContacts() async {
    DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');
    var event = await usersRef.once();

    DataSnapshot snapshot = event.snapshot;
    List<Contact> fetchedContacts = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> users = snapshot.value as Map<dynamic, dynamic>;
      users.forEach((key, value) {
        Contact contact = Contact(
          id: value['id'],
          username: value['username'],
          email: value['email'],
          avatar: value['avatar'],
        );
        fetchedContacts.add(contact);
      });
    }

    setContacts(fetchedContacts);
  }



  void setContacts(List<Contact> newContacts) {
    contacts = newContacts;
    notifyListeners();
  }
}
