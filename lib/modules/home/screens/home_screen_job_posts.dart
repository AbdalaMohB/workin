import 'package:flutter/material.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/modules/home/components/job_card.dart';
import 'package:workin/modules/home/screens/employee_picker_screen.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class HomeScreenJobPosts extends StatelessWidget {
  final List<JobPosterModel> jobPosters;
  final Future<void> Function(String id) onApply;
  final Future<void> Function(String id) onUnapply;
  const HomeScreenJobPosts({
    super.key,
    required this.jobPosters,
    required this.onApply,
    required this.onUnapply,
  });
  List<Widget> _builder(BuildContext context) {
    List<Widget> posters = [];
    for (JobPosterModel post in jobPosters) {
      posters.add(
        JobCard(
          jobPost: post,
          posterName: post.ownerName ?? "You",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EmployeePickerScreen(applicantIDs: post.applicantIDs);
                },
              ),
            );
          },
          onApply: () async {
            await onApply(post.jobID);
          },
          onUnapply: () async {
            await onUnapply(post.jobID);
          },
        ),
      );
    }
    if (posters.isEmpty) {
      posters.add(
        Center(child: Text("Nothing Here.", style: AppTextStyles.normal)),
      );
    }
    return posters;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: jobPosters.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: _builder(context),
      ),
    );
  }
}
