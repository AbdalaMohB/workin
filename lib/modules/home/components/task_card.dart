import 'package:flutter/material.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/models/task_model.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/custom_spacer.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final String assigneeName;
  const TaskCard({super.key, required this.task, required this.assigneeName});

  @override
  State<StatefulWidget> createState() {
    return _TaskCardState();
  }
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return expandedHorizontal(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 2,
        color: AppColors.secondaryBg,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
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
                    Text(widget.task.name, style: AppTextStyles.header),
                  ],
                ),
                customSpacer(
                  verticalSpace: SizeService.getHeightPercentage(
                    context,
                    percentage: 0.02,
                  ),
                ),
                Text(
                  "Assigned To: ${widget.assigneeName}",
                  style: AppTextStyles.normal,
                ),
                Text(widget.task.desc, style: AppTextStyles.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
