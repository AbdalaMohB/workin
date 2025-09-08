import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/firestore_service.dart';
import 'package:workin/core/services/hive_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/models/job_model.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/models/job_profile_model.dart';
import 'package:workin/models/task_container.dart';
import 'package:workin/models/task_local_model.dart';
import 'package:workin/models/task_model.dart';
import 'package:workin/modules/home/components/job_post_dialog.dart';
import 'package:workin/modules/home/components/task_dialog.dart';

class HomeProvider extends ChangeNotifier {
  late int currentTab;
  late bool isLoading;
  late List<JobPosterModel> posts;
  late GlobalKey<FormState> dialogFormKey;
  late bool isJobFullTime;
  late TextEditingController jobNameController;
  late TextEditingController jobDescController;
  late TextEditingController jobRateController;
  String? rate;

  String selectedEmployee = "";

  late List<TaskContainer> tasks;
  late List<JobProfileModel> employees;
  late GlobalKey<FormState> taskFormKey;

  Future<void> _getEmployees() async {
    employees = [];
    final managedEmployees = await FirestoreService.getManagerProfile();
    final devs = await FirestoreService.getDevsById(
      (managedEmployees).managedEmployeeIDsWithJobs.keys.toList(),
    );
    for (var i = 0; i < devs.length; i++) {
      employees.add(
        JobProfileModel(
          job: managedEmployees.managedEmployeeIDsWithJobs[devs[i].devID]!,
          employee: devs[i],
        ),
      );
    }
    return;
  }

  Future<void> _getTasks() async {
    try {
      tasks = await FirestoreService.getTasksByUserId(
        isOwner: FirebaseAuthService.currentUser?.isOwner ?? false,
      );
      if (!(FirebaseAuthService.currentUser?.isOwner ?? true)) {
        await HiveService.instance.cacheTasks(
          tasks.map((container) {
            return TaskLocalModel.fromContainer(container);
          }).toList(),
        );
      }
    } catch (e) {
      tasks = [];
      rethrow;
    }
  }

  Future<void> createNewTask() async {
    TaskModel newTask = TaskModel(
      ownerID: FirebaseAuthService.user?.uid ?? "Invalid User",
      developerID: selectedEmployee,
      name: jobNameController.text,
      desc: jobDescController.text,
    );
    await FirestoreService.createNewTask(newTask);
    DeveloperModel employee =
        await FirestoreService.getEmplById(selectedEmployee) ??
        DeveloperModel.dummy();
    tasks.add(TaskContainer(task: newTask, dev: employee));
    notifyListeners();
  }

  void toggleFullTime(bool? val) {
    isJobFullTime = val ?? false;
    notifyListeners();
  }

  void showDialog(BuildContext context) {
    _resetControllers();
    if (currentTab == 0) {
      showJobDialog(context);
    } else {
      showTaskDialog(context);
    }
  }

  void showTaskDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      transitionBuilder: (c, a1, a2, widget) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;
        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(parent: a1, curve: curve);
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: Opacity(
            opacity: a1.value,
            child: getTaskDialog(context: c),
          ),
        );
      },
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 900),
      pageBuilder: (c, a1, a2) {
        return Center();
      },
    );
  }

  void showJobDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      transitionBuilder: (c, a1, a2, widget) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;
        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(parent: a1, curve: curve);
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: Opacity(
            opacity: a1.value,
            child: getJobPostDialog(context: c),
          ),
        );
      },
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 900),
      pageBuilder: (c, a1, a2) {
        return Center();
      },
    );
  }

  Future<void> _getUser() async {
    FirebaseAuthService.currentUser = await FirestoreService.getUserById(
      FirebaseAuthService.user?.uid ?? "",
    );
    if (!(FirebaseAuthService.currentUser?.isOwner ?? true)) {
      final payment = await FirestoreService.getCurrentRate();
      rate = "\$${payment[true]}/M : \$${payment[false]}/H";
    }
  }

  Future<void> postJob(JobModel job) async {
    JobPosterModel newPost = await FirestoreService.createNewJobPost(job);
    posts.add(newPost);
    _resetControllers();
    notifyListeners();
  }

  Future<void> _initPosts() async {
    try {
      if (FirebaseAuthService.currentUser?.isOwner ?? false) {
        posts = await FirestoreService.getPostedJobs();
      } else {
        posts = await FirestoreService.getJobs();
      }
    } catch (e) {
      posts = [];
    }
  }

  void _resetControllers() {
    jobDescController.text = "";
    jobNameController.text = "";
    jobRateController.text = "";
  }

  void _initControllers() {
    jobDescController = TextEditingController();
    jobNameController = TextEditingController();
    jobRateController = TextEditingController();
  }

  Future<void> init() async {
    currentTab = 0;
    isLoading = true;
    isJobFullTime = true;
    dialogFormKey = GlobalKey();
    taskFormKey = GlobalKey();
    await Future.wait([_getUser(), _initPosts(), _getTasks(), _getEmployees()]);
    _initControllers();
    isLoading = false;
    notifyListeners();
  }

  Future<void> applyToJob(String jobID) async {
    await FirestoreService.applyToJob(jobID);
  }

  Future<void> cancelJob(String jobID) async {
    await FirestoreService.cancelJob(jobID);
  }

  @override
  void dispose() {
    super.dispose();
    jobNameController.dispose();
    jobDescController.dispose();
    jobRateController.dispose();
  }

  void onTabChange(int newTab) {
    currentTab = newTab;
    notifyListeners();
  }
}
