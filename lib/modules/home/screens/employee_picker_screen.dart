import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/modules/home/components/employee_card.dart';
import 'package:workin/modules/home/providers/employee_provider.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class EmployeePickerScreen extends StatelessWidget {
  final List<String> applicantIDs;
  const EmployeePickerScreen({super.key, required this.applicantIDs});

  List<Widget> _builder(EmployeeProvider provider) {
    List<Widget> items = [];
    for (DeveloperModel dev in provider.employees) {
      items.add(EmployeeCard(employee: dev));
    }
    return items;
  }

  Widget _body() {
    return Consumer<EmployeeProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (provider.employees.isEmpty) {
          return Center(child: Text("No Data", style: AppTextStyles.normal));
        }
        return SingleChildScrollView(
          child: Column(children: _builder(provider)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeProvider>().init(applicantIDs);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBg,
        iconTheme: IconThemeData(color: AppColors.secondaryFg),
      ),
      backgroundColor: AppColors.primaryBg,
      body: _body(),
    );
  }
}
