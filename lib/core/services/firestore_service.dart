import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/models/job_model.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/models/manager_model.dart';
import 'package:workin/models/task_container.dart';
import 'package:workin/models/task_model.dart';
import 'package:workin/models/user_model.dart';

abstract class FirestoreService {
  static const String _collectionKey = 'users';
  static const String _taskCollectionKey = 'tasks';
  static const String _jobCollectionKey = 'jobs';
  static const String _managerCollectionKey = 'managers';
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

  static Future<DeveloperModel?> getEmplById(String userId) async {
    try {
      final response = await _instance
          .collection(_collectionKey)
          .doc(userId)
          .get();
      final DeveloperModel user = DeveloperModel.fromJson(response.data()!);
      user.devID = response.reference.path.split("/").last;
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

  static Future<List<ManagerModel>> getManagersByDevID(String userId) async {
    final response = await _instance
        .collection(_managerCollectionKey)
        .where("managedEmployeeIDsWithJob.$userId", isGreaterThan: '')
        .get();
    return response.docs.map((managers) {
      return ManagerModel.fromJson(managers.data());
    }).toList();
  }

  static Future<ManagerModel> getManagerProfile() async {
    final response = await _instance
        .collection(_managerCollectionKey)
        .doc(FirebaseAuthService.user?.uid ?? "Invalid")
        .get();
    return ManagerModel.fromJson(
      response.data() ?? {"managedEmployeeIDsWithJob": {}},
    );
  }

  static Future<List<TaskContainer>> _getTaskContainers(
    List<TaskModel> tasks,
  ) async {
    List<TaskContainer> containers = [];
    for (TaskModel task in tasks) {
      final dev = await getEmplById(task.developerID);
      containers.add(
        TaskContainer(dev: dev ?? DeveloperModel.dummy(), task: task),
      );
    }
    return containers;
  }

  static Future<List<TaskContainer>> getTasksByUserId({
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
    return await _getTaskContainers(tasks);
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

  static Future<List<DeveloperModel>> getDevsById(List<String> IDs) async {
    final List<DeveloperModel> users = [];
    for (String id in IDs) {
      UserModel dev =
          await getEmplById(id) ?? UserModel(name: "", isOwner: false);
      users.add(DeveloperModel.fromJson(dev.toJson()));
    }

    return users;
  }

  static Future<List<JobPosterModel>> getPostedJobs() async {
    final response = await _instance
        .collection(_jobCollectionKey)
        .where(
          "ownerID",
          isEqualTo: FirebaseAuthService.user?.uid ?? "invalidOwnerId",
        )
        .get();
    final List<JobPosterModel> jobs = response.docs.map((devs) {
      return JobPosterModel.fromJson(devs.data());
    }).toList();
    return jobs;
  }

  static Future<void> createManagerProfile() async {
    try {
      await _instance
          .collection(_managerCollectionKey)
          .doc(FirebaseAuthService.user!.uid)
          .set(ManagerModel().toJson());
    } catch (e) {
      rethrow;
    }
  }

  static Future<JobPosterModel> createNewJobPost(JobModel job) async {
    try {
      JobPosterModel jobPost = JobPosterModel(
        ownerID: FirebaseAuthService.user?.uid ?? "",
        applicantIDs: [],
        job: job,
      );
      await _instance.collection(_jobCollectionKey).add(jobPost.toJson());
      return jobPost;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createNewTask(TaskModel task) async {
    try {
      task.ownerID = FirebaseAuthService.user?.uid ?? "invalidOwnerId";
      await _instance.collection(_taskCollectionKey).add(task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<bool, double>> getCurrentRate() async {
    try {
      final response = await _instance
          .collection(_managerCollectionKey)
          .where(
            "managedEmployeeIDsWithJob.${FirebaseAuthService.user?.uid ?? "Invalid User ID"}",
            isNotEqualTo: "",
          )
          .get();
      Map<bool, double> jobsWithIDs = {true: 0, false: 0};
      List<ManagerModel> md = response.docs.map((m) {
        return ManagerModel.fromJson(m.data());
      }).toList();
      for (ManagerModel m in md) {
        JobModel? relevantJobs =
            m.managedEmployeeIDsWithJobs[FirebaseAuthService.user?.uid ??
                "Invalid User"];
        if (relevantJobs == null) {
          continue;
        }

        jobsWithIDs.update(
          relevantJobs.isFullTime,
          (value) {
            return value + relevantJobs.rate;
          },
          ifAbsent: () {
            return 0;
          },
        );
      }
      return jobsWithIDs;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> acceptCandidateDeveloper(
    String developerID,
    String jobID,
  ) async {
    try {
      final response = await _instance
          .collection(_jobCollectionKey)
          .doc(jobID)
          .get();
      await _instance
          .collection(_managerCollectionKey)
          .doc(FirebaseAuthService.user?.uid ?? "invalidOwnerId")
          .update({
            "managedEmployeeIDsWithJob.$developerID": response.data()?['job'],
          });

      await _instance.collection(_jobCollectionKey).doc(jobID).delete();

      //.update({
      // "applicantIDs": FieldValue.arrayRemove([developerID]),
      //});
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<JobPosterModel>> getJobs() async {
    final response = await _instance.collection(_jobCollectionKey).get();
    List<JobPosterModel> posters = response.docs.map((job) {
      JobPosterModel j = JobPosterModel.fromJson(job.data());
      j.jobID = job.reference.path.split("/").last;
      return j;
    }).toList();
    for (var i = 0; i < posters.length; i++) {
      posters[i].ownerName =
          (await getUserById(posters[i].ownerID))?.name ?? "";
    }
    return posters;
  }

  static Future<void> applyToJob(String jobID) async {
    await _instance.collection(_jobCollectionKey).doc(jobID).update({
      "applicantIDs": FieldValue.arrayUnion([FirebaseAuthService.user!.uid]),
    });
  }

  static Future<void> cancelJob(String jobID) async {
    await _instance.collection(_jobCollectionKey).doc(jobID).update({
      "applicantIDs": FieldValue.arrayRemove([FirebaseAuthService.user!.uid]),
    });
  }
}
