import 'package:flutter/widgets.dart';
import 'package:workin/core/services/firestore_service.dart';
import 'package:workin/models/developer_model.dart';

class EmployeeProvider extends ChangeNotifier {
  late List<DeveloperModel> employees;
  late bool isLoading;
  Future<void> _getEmployees(List<String> IDs) async {
    try {
      employees = await FirestoreService.getDevsById(IDs);
    } catch (e) {
      employees = [];
      rethrow;
    }
  }

  Future<void> init(List<String> IDs) async {
    isLoading = true;
    await _getEmployees(IDs);
    isLoading = false;
    notifyListeners();
  }
}
