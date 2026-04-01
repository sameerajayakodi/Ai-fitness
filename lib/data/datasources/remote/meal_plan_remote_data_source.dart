import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_fitness/data/models/meal_plan_model.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';

abstract class MealPlanRemoteDataSource {
  Future<MealPlanModel?> getActiveMealPlan(String userId);
  Future<void> createMealPlan(MealPlanModel mealPlan);
  Future<void> updateMealPlan(MealPlanModel mealPlan);
  Future<List<MealPlanModel>> getMealPlanHistory(String userId);
  Stream<MealPlanModel?> watchActiveMealPlan(String userId);
}

class MealPlanRemoteDataSourceImpl implements MealPlanRemoteDataSource {
  final FirebaseFirestore _firestore;

  MealPlanRemoteDataSourceImpl(this._firestore);

  @override
  Future<MealPlanModel?> getActiveMealPlan(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('mealPlans')
          .where('userId', isEqualTo: userId)
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return null;

      return MealPlanModel.fromJson({
        ...querySnapshot.docs.first.data(),
        'id': querySnapshot.docs.first.id,
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get active meal plan', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> createMealPlan(MealPlanModel mealPlan) async {
    try {
      // Deactivate previous plans
      await _firestore
          .collection('mealPlans')
          .where('userId', isEqualTo: mealPlan.userId)
          .where('isActive', isEqualTo: true)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.update({'isActive': false});
        }
      });

      // Create new plan
      await _firestore.collection('mealPlans').doc(mealPlan.id).set(
        mealPlan.toJson(),
      );
      AppLogger.info('Meal plan created: ${mealPlan.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create meal plan', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateMealPlan(MealPlanModel mealPlan) async {
    try {
      await _firestore.collection('mealPlans').doc(mealPlan.id).update(
        mealPlan.toJson(),
      );
      AppLogger.info('Meal plan updated: ${mealPlan.id}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update meal plan', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<MealPlanModel>> getMealPlanHistory(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('mealPlans')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => MealPlanModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get meal plan history', e, stackTrace);
      rethrow;
    }
  }

  @override
  Stream<MealPlanModel?> watchActiveMealPlan(String userId) {
    try {
      return _firestore
          .collection('mealPlans')
          .where('userId', isEqualTo: userId)
          .where('isActive', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) return null;
        return MealPlanModel.fromJson({
          ...snapshot.docs.first.data(),
          'id': snapshot.docs.first.id,
        });
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to watch active meal plan', e, stackTrace);
      rethrow;
    }
  }
}
