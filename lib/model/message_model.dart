
class Message {
  final String text;
  final DateTime date;
  final String senderId;
  final String recepientId;
  final String timestamp;
  final String? base64Image;

  const Message({
    required this.text,
    required this.date,
    required this.senderId,
    required this.recepientId,
    required this.timestamp,
    this.base64Image,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'date': date.toString(),
      'senderId': senderId,
      'recepientId': recepientId,
      'timestamp': timestamp,
      'base64Image': base64Image,
    };
  }
}
