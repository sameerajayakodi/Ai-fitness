import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_fitness/data/models/chat_message_model.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';

abstract class ChatRemoteDataSource {
  Future<void> saveChatMessage(ChatMessageModel message);
  Future<List<ChatMessageModel>> getChatHistory(String userId);
  Stream<List<ChatMessageModel>> watchChatHistory(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;

  ChatRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> saveChatMessage(ChatMessageModel message) async {
    try {
      await _firestore.collection('chatHistory').doc(message.id).set(
        message.toJson(),
      );
      AppLogger.info('Chat message saved: ${message.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save chat message', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatHistory(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('chatHistory')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(50)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              ChatMessageModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList()
          .reversed
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get chat history', e, stackTrace);
      rethrow;
    }
  }

  @override
  Stream<List<ChatMessageModel>> watchChatHistory(String userId) {
    try {
      return _firestore
          .collection('chatHistory')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  ChatMessageModel.fromJson({...doc.data(), 'id': doc.id}))
              .toList());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to watch chat history', e, stackTrace);
      rethrow;
    }
  }
}
