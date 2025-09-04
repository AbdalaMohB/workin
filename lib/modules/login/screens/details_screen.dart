import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/misc/app_validation.dart';
import 'package:workin/modules/login/providers/login_provider.dart';
import 'package:workin/shared/components/auto_expanded.dart';
import 'package:workin/shared/components/text_field.dart';
import 'package:workin/shared/resources/app_colors.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  List<Widget> _getFormFields(LoginProvider provider) {
    return [
      TaskFormField.basic(
        title: "Years of Experience",
        maxLines: 1,
        controller: provider.yearsOfExperience,
        validator: AppValidation.validateNumber,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
      TaskFormField.basic(
        title: "Job Title",
        maxLines: 1,
        controller: provider.job,
        validator: AppValidation.validateJobName,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
      TaskFormField.basic(
        title: "CV (Optional)",
        maxLines: 3,
        controller: provider.cv,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderColor: AppColors.primaryFg,
      ),
    ];
  }

  Widget _hint() {
    return Text(
      "Just one last step. Please provide the following information:",
      style: TextStyle(color: AppColors.primaryFg, fontSize: 15),
    );
  }

  Widget _submitButton(void Function() onClick) {
    return expandedHorizontal(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: MaterialButton(
        color: AppColors.primaryFg,
        splashColor: AppColors.splash,
        onPressed: onClick,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryFg, width: 1),
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Text("Submit", style: TextStyle(color: AppColors.primaryBg)),
      ),
    );
  }

  Widget _body() {
    return Consumer<LoginProvider>(
      builder: (cont, provider, _) {
        return Form(
          key: provider.extraKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  [_hint()] +
                  _getFormFields(provider) +
                  [
                    _submitButton(() {
                      provider.registerDev(cont);
                    }),
                  ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
