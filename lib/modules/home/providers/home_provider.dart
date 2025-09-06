import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/firestore_service.dart';
import 'package:workin/models/job_model.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/modules/home/components/job_post_dialog.dart';

class HomeProvider extends ChangeNotifier {
  late int currentTab;
  late bool isLoading;
  late List<JobPosterModel> posts;
  late GlobalKey<FormState> dialogFormKey;
  late bool isJobFullTime;
  late TextEditingController jobNameController;
  late TextEditingController jobDescController;
  late TextEditingController jobRateController;

  void toggleFullTime(bool? val) {
    isJobFullTime = val ?? false;
    notifyListeners();
  }

  void showDialog(BuildContext context) {
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
  }

  Future<void> postJob(JobModel job) async {
    JobPosterModel newPost = await FirestoreService.createNewJobPost(job);
    posts.add(newPost);
    _resetControllers();
    notifyListeners();
  }

  Future<void> _initPosts() async {
    try {
      posts = await FirestoreService.getPostedJobs();
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
    _initControllers();
    await Future.wait([_getUser(), _initPosts()]);
    isLoading = false;
    notifyListeners();
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
