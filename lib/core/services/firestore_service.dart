import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/models/task_model.dart';
import 'package:workin/models/user_model.dart';

abstract class FirestoreService {
  static const String _collectionKey = 'users';
  static const String _taskCollectionKey = 'tasks';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static Future<void> createNewUser(UserModel user, String userId) async {
    try {
      await _instance.collection(_collectionKey).doc(userId).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> setCurrentUser(UserModel user) async {
    try {
      await _instance
          .collection(_collectionKey)
          .doc(FirebaseAuthService.user?.uid)
          .set(user.toJson());
      FirebaseAuthService.currentUser = await getUserById(
        FirebaseAuthService.user?.uid ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> getUserById(String userId) async {
    try {
      final response = await _instance
          .collection(_collectionKey)
          .doc(userId)
          .get();
      final UserModel user = UserModel.fromJson(response.data()!);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateUserById(String userId, UserModel user) async {
    try {
      await _instance
          .collection(_collectionKey)
          .doc(userId)
          .update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  //TODO: CHANGE THIS ONE TO RETURN TASKMODEL EVENTUALLY
  static Future<void> getTaskById(String taskId) {
    return Future(() {});
  }

  static Future<List<TaskModel>> getTasksByUserId({
    required bool isOwner,
  }) async {
    final String id = isOwner ? "ownerID" : "developerID";
    final response = await _instance
        .collection(_taskCollectionKey)
        .where(id, isEqualTo: FirebaseAuthService.user?.uid ?? "")
        .get();
    final List<TaskModel> tasks = response.docs.map((task) {
      return TaskModel.fromJson(task.data());
    }).toList();
    return tasks;
  }

  static Future<List<DeveloperModel>> getEmployedDevelopers() async {
    final response = await _instance
        .collection(_collectionKey)
        .where(
          "employedBy",
          arrayContains: FirebaseAuthService.user?.uid ?? "invalidOwnerId",
        )
        .get();
    final List<DeveloperModel> developers = response.docs.map((devs) {
      return DeveloperModel.fromJson(devs.data());
    }).toList();
    return developers;
  }

  static Future<List<DeveloperModel>> getCandidateDevelopers() async {
    final response = await _instance
        .collection(_collectionKey)
        .where(
          "candidateTo",
          arrayContains: FirebaseAuthService.user?.uid ?? "invalidOwnerId",
        )
        .get();
    final List<DeveloperModel> developers = response.docs.map((devs) {
      return DeveloperModel.fromJson(devs.data());
    }).toList();
    return developers;
  }

  static Future<void> acceptCandidateDeveloper(String developerID) async {
    await _instance.collection(_collectionKey).doc(developerID).update({
      "employedBy": FieldValue.arrayUnion([FirebaseAuthService.user!.uid]),
    });
    await _instance
        .collection(_collectionKey)
        .doc(FirebaseAuthService.user!.uid)
        .update({
          "candidateIds": FieldValue.arrayRemove([developerID]),
        });
  }
}
