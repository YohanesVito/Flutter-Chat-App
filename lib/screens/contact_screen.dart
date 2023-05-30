import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/profile_screen.dart';
import '../model/contact_model.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  //navigation
  void navigateToChatScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      ),
    );
  }

  void navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.person_rounded),
              onPressed: () {
                navigateToProfileScreen(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('Contact'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(contact.avatar),
                ),
                title: Text(contact.username),
                subtitle: Text(contact.email),
                onTap: () {
                  // Handle onTap action here
                  navigateToChatScreen(context);
                  // Example: Navigator.push(...)
                },
                onLongPress: () {
                  // Handle onLongPress action here
                },
              ),
              const Divider(
                height: 1.0,
                indent: 1.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
