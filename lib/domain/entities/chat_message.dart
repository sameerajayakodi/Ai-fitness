import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String userId;
  final String text;
  final String language; // 'sinhala' or 'english'
  final bool isUserMessage;
  final DateTime timestamp;
  final String? geminiText; // Original response from Gemini in Sinhala

  const ChatMessage({
    required this.id,
    required this.userId,
    required this.text,
    required this.language,
    required this.isUserMessage,
    required this.timestamp,
    this.geminiText,
  });

  ChatMessage copyWith({
    String? id,
    String? userId,
    String? text,
    String? language,
    bool? isUserMessage,
    DateTime? timestamp,
    String? geminiText,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      language: language ?? this.language,
      isUserMessage: isUserMessage ?? this.isUserMessage,
      timestamp: timestamp ?? this.timestamp,
      geminiText: geminiText ?? this.geminiText,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        text,
        language,
        isUserMessage,
        timestamp,
        geminiText,
      ];
}
