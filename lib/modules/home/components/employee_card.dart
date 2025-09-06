import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/models/job_poster_model.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/custom_spacer.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class EmployeeCard extends StatefulWidget {
  final DeveloperModel employee;
  late bool _isEmployeesTab;

  EmployeeCard({super.key, required this.employee}) {
    _isEmployeesTab = false;
  }
  EmployeeCard.employeeTab({super.key, required this.employee}) {
    _isEmployeesTab = true;
  }

  @override
  State<StatefulWidget> createState() {
    return _EmployeeCardState();
  }
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  void initState() {
    super.initState();
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
                    Text(widget.employee.name, style: AppTextStyles.header),
                    Spacer(),
                    IconButton(
                      onPressed: () async {},
                      icon: Icon(Icons.thumb_up, color: AppColors.primaryFg),
                    ),
                  ],
                ),
                customSpacer(
                  verticalSpace: SizeService.getHeightPercentage(
                    context,
                    percentage: 0.02,
                  ),
                ),
                Text(widget.employee.job, style: AppTextStyles.normal),
                Text(
                  "Years of Experience: ${widget.employee.yearsOfExperience}",
                  style: AppTextStyles.normal,
                ),
                Text(widget.employee.cv ?? "", style: AppTextStyles.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
