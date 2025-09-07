import 'package:flutter/material.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/modules/home/enums/employee_tabs.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/custom_spacer.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class EmployeeCard extends StatefulWidget {
  final DeveloperModel employee;
  late EmployeeTabs currentTab;
  late void Function(String id) onApply;
  EmployeeCard._internal({
    super.key,
    required this.employee,
    required this.onApply,
    required this.currentTab,
  });
  EmployeeCard({
    Key? key,
    required DeveloperModel employee,
    required void Function(String value) onApply,
  }) : this._internal(
         key: key,
         employee: employee,
         onApply: onApply,
         currentTab: EmployeeTabs.hiring,
       );
  EmployeeCard.employeeTab({
    Key? key,
    required DeveloperModel employee,
    required void Function(String v) onApply,
  }) : this._internal(
         key: key,
         employee: employee,
         onApply: onApply,
         currentTab: EmployeeTabs.employee,
       );
  EmployeeCard.taskTab({
    Key? key,
    required DeveloperModel employee,
    required void Function(String value) onApply,
  }) : this._internal(
         key: key,
         employee: employee,
         onApply: onApply,
         currentTab: EmployeeTabs.task,
       );

  @override
  State<StatefulWidget> createState() {
    return _EmployeeCardState();
  }
}

class _EmployeeCardState extends State<EmployeeCard> {
  late TextStyle _details;
  late TextStyle _name;
  @override
  void initState() {
    super.initState();
    switch (widget.currentTab) {
      case EmployeeTabs.employee:
        _name = TextStyle(color: AppColors.primaryFg, fontSize: 18);
        _details = TextStyle(
          color: AppColors.secondaryText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );
        break;
      case EmployeeTabs.hiring:
        _name = AppTextStyles.headerNoHighlight;
        _details = AppTextStyles.highlighted;
        break;
      case EmployeeTabs.task:
        _name = AppTextStyles.header;
        _details = AppTextStyles.highlighted;
        break;
    }
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
                    Text(widget.employee.name, style: _name),
                    Spacer(),
                    IconButton(
                      onPressed: () async {
                        widget.onApply(widget.employee.devID);
                      },
                      icon: Icon(
                        widget.currentTab != EmployeeTabs.employee
                            ? Icons.thumb_up
                            : Icons.add,
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
                Text("Position: ${widget.employee.job}", style: _details),
                Text(
                  "Years of Experience: ${widget.employee.yearsOfExperience}",
                  style: _details,
                ),
                if (widget.currentTab == EmployeeTabs.hiring)
                  Text(widget.employee.cv ?? "", style: _details),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
