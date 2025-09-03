import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/misc/app_validation.dart';
import 'package:workin/modules/login/providers/login_provider.dart';
import 'package:workin/shared/components/text_field.dart';
import 'package:workin/shared/resources/app_colors.dart';

class DetailsScreen extends StatelessWidget {
  List<Widget> _getFormFields(LoginProvider provider) {
    return [
      TaskFormField.basic(
        title: "Cheese",
        maxLines: 1,
        //controller: emailController,
        validator: AppValidation.validateEmail,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
      TaskFormField.password(
        title: "Password",
        maxLines: 1,
        //controller: passwordController,
        validator: AppValidation.validatePassword,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
    ];
  }

  Widget _body() {
    return Consumer<LoginProvider>(
      builder: (cont, provider, _) {
        return Column(children: _getFormFields(provider));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
