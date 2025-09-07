import 'package:flutter/widgets.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/modules/home/components/employee_card.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class EmployeesScreen extends StatelessWidget {
  final List<DeveloperModel> employees;

  const EmployeesScreen({super.key, required this.employees});

  List<Widget> _builder(BuildContext context) {
    List<Widget> cards = [];
    for (DeveloperModel employee in employees) {
      EmployeeCard card = EmployeeCard.employeeTab(
        employee: employee,
        onApply: (id) {},
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
