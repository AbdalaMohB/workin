import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/misc/app_validation.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/models/job_model.dart';
import 'package:workin/modules/home/providers/home_provider.dart';
import 'package:workin/shared/components/app_checkbox.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/text_field.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

Widget _getFormBody(BuildContext context, HomeProvider provider) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            "Please Enter Post Information",
            style: AppTextStyles.header,
            textAlign: TextAlign.center,
          ),
        ),
        TaskFormField.basic(
          title: "Job Name",
          controller: provider.jobNameController,
          validator: AppValidation.validateJobName,
          maxLines: 1,
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        TaskFormField.basic(
          title: "Job Desc",
          controller: provider.jobDescController,
          validator: AppValidation.validateDesc,
          maxLines: 3,
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        TaskFormField.basic(
          title: "Rate per ${provider.isJobFullTime ? "Month" : "Hour"}",
          validator: AppValidation.validateNumber,
          controller: provider.jobRateController,
          maxLines: 1,
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
        AppCheckbox(
          initState: provider.isJobFullTime,
          onChange: provider.toggleFullTime,
          checkedColor: AppColors.primaryFg,
          padding: EdgeInsets.only(left: 15),
          label: Text("Is This Job Full Time?", style: AppTextStyles.normal),
        ),
        expandedHorizontal(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
            onPressed: () async {
              if (provider.dialogFormKey.currentState!.validate()) {
                Navigator.pop(context);
                JobModel job = JobModel(
                  jobName: provider.jobNameController.text,
                  jobDesc: provider.jobDescController.text,
                  rate: double.parse(provider.jobRateController.text.trim()),
                  isFullTime: provider.isJobFullTime,
                );
                provider.postJob(job);
              }
            },
            color: AppColors.primaryFg,
            child: Text("Post"),
          ),
        ),
      ],
    ),
  );
}

Dialog getJobPostDialog({required BuildContext context}) {
  double height = SizeService.getHeightPercentage(context, percentage: 0.6);
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(15),
    ),
    constraints: BoxConstraints(maxHeight: height),
    backgroundColor: AppColors.secondaryBg,
    child: Consumer<HomeProvider>(
      builder: (consumerContext, provider, _) {
        return Form(
          key: provider.dialogFormKey,
          child: _getFormBody(context, provider),
        );
      },
    ),
  );
}
