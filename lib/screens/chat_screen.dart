import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../model/message_model.dart';
import 'contact_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  void navigateToContactScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      ),
    );
  }

  // Method to open the gallery
  void _openGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Handle the picked image here
      // You can display it, upload it, or perform any other operation
    }
  }

  @override
  Widget build(BuildContext context) {
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
              order: GroupedListOrder.DESC,
              //untuk menempelkan tanggal
              useStickyGroupSeparators: true,
              elements: messages,
              //sortir berdasarkan waktu
              groupBy: (messages) => DateTime(
                  messages.date.year, messages.date.month, messages.date.day),
              //sortir berdasarkan bulan
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
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text),
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
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Type your message here...',
                    ),
                    onSubmitted: (text) {
                      final message = Message(
                        text: text,
                        date: DateTime.now(),
                        isSentByMe: true,
                      );

                      setState(() {
                        messages.add(message);
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    _openGallery();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () {
                    _openGallery();
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
                        isSentByMe: true,
                      );

                      setState(() {
                        messages.add(message);
                      });

                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
