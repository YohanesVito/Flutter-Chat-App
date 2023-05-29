List<Message> messages = [
  Message(
    text: 'On the way',
    date: DateTime.now().subtract(const Duration(minutes: 1)),
    isSentByMe: true,
  ),
  Message(
    text: "I'm here, where are u now?",
    date: DateTime.now().subtract(const Duration(minutes: 1)),
    isSentByMe: false,
  ),
  Message(
    text: 'See u there!',
    date: DateTime.now().subtract(const Duration(minutes: 1)),
    isSentByMe: false,
  ),
  Message(
    text: 'That sounds great!',
    date: DateTime.now().subtract(const Duration(minutes: 5)),
    isSentByMe: true,
  ),
  Message(
    text: '-7.753508, 110.223932',
    date: DateTime.now().subtract(const Duration(minutes: 10)),
    isSentByMe: false,
  ),
  Message(
    text: 'What do you think?',
    date: DateTime.now().subtract(const Duration(minutes: 15)),
    isSentByMe: true,
  ),
  Message(
    text: "Sure, where?",
    date: DateTime.now().subtract(const Duration(days: 1, minutes: 20)),
    isSentByMe: false,
  ),
  Message(
    text: "Let's meet at 3 PM.",
    date: DateTime.now().subtract(const Duration(days: 1, minutes: 21)),
    isSentByMe: true,
  ),
  Message(
    text: 'Hi!',
    date: DateTime.now().subtract(const Duration(days: 3, minutes: 20)),
    isSentByMe: false,
  ),
  Message(
    text: 'Hello there',
    date: DateTime.now().subtract(const Duration(days: 5, minutes: 35)),
    isSentByMe: true,
  ),
].reversed.toList();

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}
