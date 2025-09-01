import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workin/core/misc/app_validation.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/text_field.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_sizes.dart';

Widget getFormButton({
  required void Function() onLogin,
  required void Function() onRegister,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 28),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primaryFg, width: 2),
              borderRadius: BorderRadiusGeometry.circular(15),
            ),
            onPressed: onRegister,
            color: AppColors.primaryBg,
            splashColor: AppColors.primaryFg,
            child: Text(
              "Register",
              style: TextStyle(color: AppColors.primaryFg),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 28),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primaryFg, width: 2),
              borderRadius: BorderRadiusGeometry.circular(15),
            ),
            onPressed: onLogin,
            color: AppColors.primaryBg,
            splashColor: AppColors.primaryFg,
            child: Text("Login", style: TextStyle(color: AppColors.primaryFg)),
          ),
        ),
      ),
    ],
  );
}

Widget _getUsernameField() {
  return TaskFormField.basic(
    title: "Username",
    maxLines: 1,
    validator: AppValidation.validateUsername,
    padding: EdgeInsets.symmetric(horizontal: 20),
    borderColor: AppColors.primaryFg,
  );
}

Widget getFormFields() {
  return Column(
    children: [
      TaskFormField.basic(
        title: "Email",
        maxLines: 1,
        validator: AppValidation.validateEmail,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
      TaskFormField.password(
        title: "Password",
        maxLines: 1,
        validator: AppValidation.validatePassword,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
    ],
  );
}

Dialog getRegistrationDialog({
  required void Function() onTrueRegister,
  required BuildContext context,
}) {
  double dimension = SizeService.getWidthPercentage(context, percentage: 0.6);
  return Dialog(
    constraints: BoxConstraints(maxHeight: dimension),
    backgroundColor: AppColors.primaryBg,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.primaryFg, width: 3),
      borderRadius: BorderRadiusGeometry.circular(15),
    ),
    child: _getDialogBody(
      onTrueRegister: onTrueRegister,
      verticalSpace: dimension / 9,
    ),
  );
}

Widget _getDialogBody({
  required void Function() onTrueRegister,
  double? verticalSpace,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: verticalSpace ?? 0),
        child: Text(
          "Please Enter Your New Username",
          style: TextStyle(color: AppColors.primaryFg),
        ),
      ),
      _getUsernameField(),
      expandedHorizontal(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.primaryFg, width: 2),
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          onPressed: onTrueRegister,
          color: AppColors.primaryBg,
          splashColor: AppColors.primaryFg,
          child: Text("Submit", style: TextStyle(color: AppColors.primaryFg)),
        ),
      ),
    ],
  );
}

List<Widget> getLoginForm({
  required void Function() onLogin,
  required void Function() onRegister,
}) {
  return [
    getFormFields(),
    getFormButton(onLogin: onLogin, onRegister: onRegister),
  ];
}
