import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/model/contact_model.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/message_model.dart';
import '../providers/chat_provider.dart';
import 'contact_screen.dart';

class ChatScreen extends StatefulWidget {
  final Contact contact;

  const ChatScreen({required this.contact, Key? key}) : super(key: key);

  @override
  State createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  File? image;

  Future pickImage(ImageSource gallery) async {
    try {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemporary = File(pickedImage.path);
      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void navigateToContactScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      ),
    );
  }

  void sendMessageToRealtimeDatabase(Message message) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    var senderId = currentUser?.uid.toString();

    return FutureBuilder<List<Message>>(
      future: chatProvider.getMessages(currentUser, widget.contact.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the messages
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle the error case
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Retrieve the messages from the snapshot's data
          final List<Message> messages = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  navigateToContactScreen(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Chat'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GroupedListView<Message, DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    useStickyGroupSeparators: true,
                    elements: messages,
                    groupBy: (messages) => DateTime(
                        messages.date.year,
                        messages.date.month,
                        messages.date.day),
                    groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, Message message) => Align(
                      alignment: senderId == message.senderId
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message.text.isNotEmpty) Text(message.text),
                              if (message.base64Image!.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Image.memory(
                                    base64Decode(message.base64Image!),
                                    width:  200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'Type your message here...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.photo),
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final text = _textController.text;
                          if (text.isNotEmpty) {
                            final message = Message(
                              text: text,
                              date: DateTime.now(),
                              senderId: senderId!,
                              recepientId: widget.contact.id, // Fixed typo here
                              timestamp: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              base64Image: image != null
                                  ? base64Encode(image!.readAsBytesSync())
                                  : '',
                            );

                            setState(() {
                              messages.add(message); // Insert the new message at the beginning of the list
                              sendMessageToRealtimeDatabase(message);
                              image = null; // Reset the selected image
                            });

                            _textController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle the case when there are no messages
          return Text('No messages found.');
        }
      },
    );
  }
}
