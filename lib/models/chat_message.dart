import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final String senderId;
  final String receiverId;

  ChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.senderId,
    required this.receiverId,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data, String documentId) {
    return ChatMessage(
      id: documentId,
      text: data['text'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }

  types.TextMessage toFlutterChatMessage() {
    return types.TextMessage(
      author: types.User(id: senderId),
      createdAt: timestamp.millisecondsSinceEpoch,
      id: id,
      text: text,
    );
  }
}
