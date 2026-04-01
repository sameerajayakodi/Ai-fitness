import 'package:ai_fitness/domain/entities/chat_message.dart';

class ChatMessageModel {
  final String id;
  final String userId;
  final String text;
  final String language;
  final bool isUserMessage;
  final DateTime timestamp;
  final String? geminiText;

  ChatMessageModel({
    required this.id,
    required this.userId,
    required this.text,
    required this.language,
    required this.isUserMessage,
    required this.timestamp,
    this.geminiText,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      text: json['text'] as String,
      language: json['language'] as String,
      isUserMessage: json['isUserMessage'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      geminiText: json['geminiText'] as String?,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessage message) {
    return ChatMessageModel(
      id: message.id,
      userId: message.userId,
      text: message.text,
      language: message.language,
      isUserMessage: message.isUserMessage,
      timestamp: message.timestamp,
      geminiText: message.geminiText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'text': text,
      'language': language,
      'isUserMessage': isUserMessage,
      'timestamp': timestamp.toIso8601String(),
      'geminiText': geminiText,
    };
  }

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      userId: userId,
      text: text,
      language: language,
      isUserMessage: isUserMessage,
      timestamp: timestamp,
      geminiText: geminiText,
    );
  }
}
