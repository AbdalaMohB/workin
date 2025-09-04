import 'package:workin/models/job_model.dart';

class ManagerModel {
  late Map<String, JobModel> managedEmployeeIDsWithJobs;

  ManagerModel({this.managedEmployeeIDsWithJobs = const {}});

  ManagerModel.fromJson(Map<String, dynamic> json) {
    managedEmployeeIDsWithJobs = {};
    for (String key in json['managedEmployeeIDsWithJobs'].keys) {
      managedEmployeeIDsWithJobs[key] = JobModel.fromJson(
        json['managedEmployeeIDsWithJob'][key],
      );
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['managedEmployeeIDsWithJob'] = {};
    for (String key in managedEmployeeIDsWithJobs.keys) {
      data['managedEmployeeIDsWithJob'][key] = managedEmployeeIDsWithJobs[key]
          ?.toJson();
    }
    return data;
  }
}
