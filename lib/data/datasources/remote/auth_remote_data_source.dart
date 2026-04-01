import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:ai_fitness/data/models/user_model.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';

abstract class AuthRemoteDataSource {
  Future<auth.User?> signUp(String email, String password, String name);
  Future<auth.User?> login(String email, String password);
  Future<void> logout();
  Future<auth.User?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<auth.User?> signUp(String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Create user profile in Firestore
        final userModel = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          photoUrl: null,
          dailyCalorieGoal: 2000,
          currentStreak: 0,
          longestStreak: 0,
          unlockedBadges: [],
          createdAt: DateTime.now(),
          lastNotificationTime: DateTime.now(),
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set(
          userModel.toJson(),
        );

        AppLogger.info('User signed up successfully: ${userCredential.user!.email}');
      }

      return userCredential.user;
    } catch (e, stackTrace) {
      AppLogger.error('Sign up failed', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<auth.User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppLogger.info('User logged in: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e, stackTrace) {
      AppLogger.error('Login failed', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      AppLogger.info('User logged out');
    } catch (e, stackTrace) {
      AppLogger.error('Logout failed', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<auth.User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }
}
