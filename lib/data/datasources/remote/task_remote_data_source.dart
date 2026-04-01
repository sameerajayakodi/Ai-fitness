import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_fitness/data/models/daily_task_model.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';

abstract class TaskRemoteDataSource {
  Future<List<DailyTaskModel>> getDailyTasks(String userId, DateTime date);
  Future<void> createTask(DailyTaskModel task);
  Future<void> updateTask(DailyTaskModel task);
  Future<void> completeTask(String taskId);
  Future<void> deleteTask(String taskId);
  Stream<List<DailyTaskModel>> watchDailyTasks(String userId, DateTime date);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore _firestore;

  TaskRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<DailyTaskModel>> getDailyTasks(String userId, DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      final querySnapshot = await _firestore
          .collection('dailyTasks')
          .where('userId', isEqualTo: userId)
          .where('dueDate', isGreaterThanOrEqualTo: startOfDay)
          .where('dueDate', isLessThan: endOfDay)
          .get();

      return querySnapshot.docs
          .map((doc) => DailyTaskModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get daily tasks', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> createTask(DailyTaskModel task) async {
    try {
      await _firestore.collection('dailyTasks').doc(task.id).set(task.toJson());
      AppLogger.info('Task created: ${task.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create task', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateTask(DailyTaskModel task) async {
    try {
      await _firestore.collection('dailyTasks').doc(task.id).update(task.toJson());
      AppLogger.info('Task updated: ${task.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update task', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> completeTask(String taskId) async {
    try {
      await _firestore.collection('dailyTasks').doc(taskId).update({
        'isCompleted': true,
        'completedAt': DateTime.now().toIso8601String(),
      });
      AppLogger.info('Task completed: $taskId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to complete task', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('dailyTasks').doc(taskId).delete();
      AppLogger.info('Task deleted: $taskId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete task', e, stackTrace);
      rethrow;
    }
  }

  @override
  Stream<List<DailyTaskModel>> watchDailyTasks(String userId, DateTime date) {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      return _firestore
          .collection('dailyTasks')
          .where('userId', isEqualTo: userId)
          .where('dueDate', isGreaterThanOrEqualTo: startOfDay)
          .where('dueDate', isLessThan: endOfDay)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) =>
                  DailyTaskModel.fromJson({...doc.data(), 'id': doc.id}))
              .toList());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to watch daily tasks', e, stackTrace);
      rethrow;
    }
  }
}
