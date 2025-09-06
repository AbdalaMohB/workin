import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/custom_spacer.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class JobCard extends StatefulWidget {
  final JobPosterModel jobPost;
  final String posterName;
  final void Function() onTap;
  final Future<void> Function() onApply;
  final Future<void> Function() onUnapply;
  const JobCard({
    super.key,
    required this.jobPost,
    required this.posterName,
    required this.onTap,
    required this.onApply,
    required this.onUnapply,
  });
  @override
  State<StatefulWidget> createState() {
    return _JobCardState();
  }
}

class _JobCardState extends State<JobCard> {
  late bool _isDeveloper;
  bool _applied = true;

  @override
  void initState() {
    super.initState();
    _isDeveloper =
        (FirebaseAuthService.user?.uid ?? "") != widget.jobPost.ownerID;
    _applied = widget.jobPost.applicantIDs.contains(
      FirebaseAuthService.user?.uid ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return expandedHorizontal(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 2,
        color: AppColors.secondaryBg,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(backgroundColor: AppColors.primaryFg),
                    customSpacer(horizontalSpace: 15),
                    Text(
                      widget.jobPost.job.jobName,
                      style: AppTextStyles.header,
                    ),
                    Spacer(),
                    if (_isDeveloper)
                      IconButton(
                        onPressed: () async {
                          if (!_applied) {
                            await widget.onApply();
                          } else {
                            await widget.onUnapply();
                          }
                          setState(() {
                            _applied = !_applied;
                          });
                        },
                        icon: Icon(
                          _applied ? Icons.check_rounded : Icons.thumb_up,
                          color: AppColors.primaryFg,
                        ),
                      ),
                  ],
                ),
                customSpacer(
                  verticalSpace: SizeService.getHeightPercentage(
                    context,
                    percentage: 0.02,
                  ),
                ),
                Text("From ${widget.posterName}", style: AppTextStyles.normal),
                Text(
                  "Pay: \$${widget.jobPost.job.rate}/${widget.jobPost.job.isFullTime ? "M" : "H"}",
                  style: AppTextStyles.normal,
                ),
                Text(widget.jobPost.job.jobDesc, style: AppTextStyles.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
