import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_fitness/data/models/nutrition_log_model.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';

abstract class NutritionRemoteDataSource {
  Future<void> logNutrition(NutritionLogModel log);
  Future<List<NutritionLogModel>> getNutritionLogs(String userId, DateTime date);
  Future<int> getDailyCalorieTotal(String userId, DateTime date);
  Stream<List<NutritionLogModel>> watchDailyNutritionLogs(String userId, DateTime date);
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  final FirebaseFirestore _firestore;

  NutritionRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> logNutrition(NutritionLogModel log) async {
    try {
      await _firestore.collection('nutritionLogs').doc(log.id).set(
        log.toJson(),
      );
      AppLogger.info('Nutrition logged: ${log.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to log nutrition', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<NutritionLogModel>> getNutritionLogs(
    String userId,
    DateTime date,
  ) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      final querySnapshot = await _firestore
          .collection('nutritionLogs')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThan: endOfDay)
          .orderBy('timestamp', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              NutritionLogModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get nutrition logs', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<int> getDailyCalorieTotal(String userId, DateTime date) async {
    try {
      final logs = await getNutritionLogs(userId, date);
      return logs.fold<int>(0, (total, log) => total + log.calories);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get daily calorie total', e, stackTrace);
      rethrow;
    }
  }

  @override
  Stream<List<NutritionLogModel>> watchDailyNutritionLogs(
    String userId,
    DateTime date,
  ) {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      return _firestore
          .collection('nutritionLogs')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThan: endOfDay)
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  NutritionLogModel.fromJson({...doc.data(), 'id': doc.id}))
              .toList());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to watch nutrition logs', e, stackTrace);
      rethrow;
    }
  }
}
