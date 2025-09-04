import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/misc/app_validation.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/modules/login/providers/login_provider.dart';
import 'package:workin/shared/components/app_checkbox.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/text_field.dart';
import 'package:workin/shared/resources/app_colors.dart';

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
              side: BorderSide(color: AppColors.primaryFg, width: 1),
              borderRadius: BorderRadiusGeometry.circular(15),
            ),
            onPressed: onRegister,
            color: AppColors.primaryFg,
            splashColor: AppColors.splash,
            child: Text(
              "Register",
              style: TextStyle(color: AppColors.secondaryBg),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 28),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primaryFg, width: 1),
              borderRadius: BorderRadiusGeometry.circular(15),
            ),
            onPressed: onLogin,
            color: AppColors.primaryFg,
            splashColor: AppColors.splash,
            child: Text(
              "Login",
              style: TextStyle(color: AppColors.secondaryBg),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _getUsernameField(TextEditingController usernameController) {
  return TaskFormField.basic(
    title: "Username",
    maxLines: 1,
    controller: usernameController,
    validator: AppValidation.validateUsername,
    padding: EdgeInsets.symmetric(horizontal: 20),
    borderColor: AppColors.primaryFg,
  );
}

Widget _getCompanyNameField(TextEditingController controller) {
  return TaskFormField.basic(
    title: "Company Name",
    maxLines: 1,
    controller: controller,
    validator: AppValidation.validateCompanyName,
    padding: EdgeInsets.symmetric(horizontal: 20),
    borderColor: AppColors.primaryFg,
  );
}

Widget getFormFields(
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  return Column(
    children: [
      TaskFormField.basic(
        title: "Email",
        maxLines: 1,
        controller: emailController,
        validator: AppValidation.validateEmail,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
      TaskFormField.password(
        title: "Password",
        maxLines: 1,
        controller: passwordController,
        validator: AppValidation.validatePassword,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
    ],
  );
}

Dialog getRegistrationDialog({required BuildContext context}) {
  double dimension = SizeService.getWidthPercentage(context, percentage: 1);
  return Dialog(
    constraints: BoxConstraints(maxHeight: dimension),
    backgroundColor: AppColors.primaryBg,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.primaryFg, width: 1),
      borderRadius: BorderRadiusGeometry.circular(15),
    ),
    child: Consumer<LoginProvider>(
      builder: (c, provider, child) {
        return Form(
          key: provider.dialogKey,
          child: _getDialogBody(
            provider: provider,
            onTrueRegister: () {
              if (provider.formIsCompletelyValid()) {
                if (provider.isOwner) {
                  provider.register(c);
                } else {
                  provider.toNextRegistrationStep(c);
                }
              }
            },
            verticalSpace: dimension / 9,
          ),
        );
      },
    ),
  );
}

Widget _getDialogBody({
  required void Function() onTrueRegister,
  required LoginProvider provider,
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
      _getUsernameField(provider.nameController),
      AppCheckbox(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        onChange: provider.ownerCheck,
        initState: provider.isOwner,
        label: Text(
          "Are You a Company Owner?",
          style: TextStyle(color: AppColors.primaryFg),
        ),
        checkedColor: AppColors.primaryFg,
      ),
      if (provider.isOwner) _getCompanyNameField(provider.companyName),
      expandedHorizontal(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.primaryFg, width: 1),
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          onPressed: onTrueRegister,
          color: AppColors.primaryFg,
          splashColor: AppColors.splash,
          child: Text("Submit", style: TextStyle(color: AppColors.primaryBg)),
        ),
      ),
    ],
  );
}

List<Widget> getLoginForm({
  required void Function() onLogin,
  required void Function() onRegister,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) {
  return [
    getFormFields(emailController, passwordController),
    getFormButton(onLogin: onLogin, onRegister: onRegister),
  ];
}
