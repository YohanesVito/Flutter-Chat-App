import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/message_model.dart';

class ChatProvider extends ChangeNotifier {
  DatabaseReference messagesRef =
  FirebaseDatabase.instance.reference().child('chats');

  ChatProvider() {
    print('messagesRef: ${messagesRef.path}');
    messagesRef.keepSynced(true); // Enable automatic syncing of data
  }

  void sendMessage(Message message) {
    String chatId = _generateChatId(message.senderId, message.recepientId);

    final chatRef = messagesRef.child(chatId);
    chatRef.child('messages').push().set(message.toJson());
  }

  String _generateChatId(String senderId, String recipientId) {
    // Sort the sender and recipient IDs alphabetically
    List<String> ids = [senderId, recipientId];
    ids.sort();

    // Combine the sorted IDs to create the chat ID
    return '${ids[0]}_${ids[1]}';
  }

  Future<List<Message>> getMessages(User? currentUser, String contactId) async {
    print('getMessages called');
    List<Message> messages = [];

    final userMessagesRef =
    messagesRef.child('${currentUser?.uid}_$contactId');

    var snapshot = await userMessagesRef.child('messages').once();
    DataSnapshot data = snapshot.snapshot;

    Map<dynamic, dynamic>? messagesData = data.value as Map<dynamic, dynamic>?;

    if (messagesData != null) {
      messagesData.forEach((messageId, message) {
        Message chatMessage = Message(
          text: message['text'],
          date: DateTime.parse(message['date']),
          senderId: message['senderId'].toString(), // Convert Value to String
          timestamp: message['timestamp'],
          recepientId: message['recepientId'],
          base64Image: message['base64Image'],
        );

        messages.add(chatMessage);
      });
    }

    print(messages.toString());
    return messages;
  }
}
