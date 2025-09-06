import 'package:flutter/material.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/modules/home/components/job_card.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class HomeScreenJobPosts extends StatelessWidget {
  final List<JobPosterModel> jobPosters;
  const HomeScreenJobPosts({super.key, required this.jobPosters});
  List<Widget> _builder() {
    List<Widget> posters = [];
    for (JobPosterModel post in jobPosters) {
      posters.add(
        JobCard(
          jobPost: post,
          posterName: "You",
          onTap: () {},
          onApply: () async {
            await Future.delayed(Duration(seconds: 1));
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
        children: _builder(),
      ),
    );
  }
}
