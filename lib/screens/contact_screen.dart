
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import '../model/contact_model.dart';
import '../providers/contact_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  //navigation
  void navigateToChatScreen(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(contact: contact,),
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
              // Implement logout functionality
            },
          ),
        ],
        title: const Text('Contact'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contactProvider, _) {
          if (contactProvider.contacts.isEmpty) {
            // Contacts haven't been fetched yet, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else {
            // Contacts have been fetched, display them in the ListView
            return ListView.builder(
              itemCount: contactProvider.contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contactProvider.contacts[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            contact.avatar == "null" ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" : contact.avatar
                        ),
                      ),
                      title: Text(contact.username),
                      subtitle: Text(contact.email),
                      onTap: () {
                        // Handle onTap action here
                        navigateToChatScreen(context, contact);
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
            );
          }
        },
      ),
    );

  }
}
