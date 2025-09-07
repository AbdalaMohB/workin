import 'package:flutter/widgets.dart';
import 'package:workin/models/job_profile_model.dart';
import 'package:workin/modules/home/components/employee_card.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class EmployeesScreen extends StatelessWidget {
  final List<JobProfileModel> employees;
  final void Function(String id) onApply;
  const EmployeesScreen({
    super.key,
    required this.employees,
    required this.onApply,
  });

  List<Widget> _builder(BuildContext context) {
    List<Widget> cards = [];
    for (JobProfileModel employee in employees) {
      EmployeeCard card = EmployeeCard.employeeTab(
        employee: employee.employee,
        onApply: (id) {
          onApply(id);
        },
        job: employee.job,
      );
      cards.add(card);
    }
    if (cards.isEmpty) {
      cards.add(
        Center(child: Text("No Tasks Here", style: AppTextStyles.normal)),
      );
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: _builder(context)));
  }
}
