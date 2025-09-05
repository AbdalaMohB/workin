import 'package:flutter/material.dart';
import 'package:workin/models/job_model.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/modules/home/components/job_card.dart';

class HomeScreenJobPosts extends StatelessWidget {
  final List<JobPosterModel>? jobPosters;
  HomeScreenJobPosts({super.key, this.jobPosters});
  JobModel fakeJob = JobModel(
    jobName: "SWE",
    rate: 5,
    isFullTime: false,
    jobDesc: "Job Description",
  );

  List<Widget> _builder() {
    List<Widget> posters = [];
    return posters;
  }

  @override
  Widget build(BuildContext context) {
    JobPosterModel jobPoster = JobPosterModel(
      ownerID: "hkda",
      applicantIDs: [],
      job: fakeJob,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          JobCard(
            jobPost: jobPoster,
            posterName: "Some Guy",
            onTap: () {},
            onApply: () async {
              await Future.delayed(Duration(seconds: 1));
            },
          ),
        ],
      ),
    );
  }
}
