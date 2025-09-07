import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/misc/app_validation.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/modules/home/providers/home_provider.dart';
import 'package:workin/shared/components/app_dropdown.dart';
import 'package:workin/shared/components/text_field.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

Widget _getFormBody(BuildContext context, HomeProvider provider) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            "Please Enter Task Information",
            style: AppTextStyles.header,
            textAlign: TextAlign.center,
          ),
        ),
        TaskFormField.basic(
          title: "Task Name",
          controller: provider.jobNameController,
          validator: AppValidation.validateJobName,
          maxLines: 1,
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        TaskFormField.basic(
          title: "Task Description",
          controller: provider.jobDescController,
          validator: AppValidation.validateDesc,
          maxLines: 3,
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        AppDropdown<String>(
          onSelect: (v) {},
          data: ["hdjfsk", "jfdkkjhs"],
          builder: (String dev, index) {
            return DropdownMenuItem(value: dev, child: Text(dev));
          },
        ),
      ],
    ),
  );
}

Dialog getTaskDialog({required BuildContext context}) {
  double height = SizeService.getHeightPercentage(context, percentage: 0.8);
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(15),
    ),
    constraints: BoxConstraints(maxHeight: height),
    backgroundColor: AppColors.secondaryBg,
    child: Consumer<HomeProvider>(
      builder: (consumerContext, provider, _) {
        return Form(
          key: provider.taskFormKey,
          child: _getFormBody(context, provider),
        );
      },
    ),
  );
}
