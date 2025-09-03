class ManagerModel {
  late Map<String, String> managedEmployeeIDsWithJobs;

  ManagerModel({this.managedEmployeeIDsWithJobs = const {}});

  ManagerModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey("managedEmployeeIDsWithJobs")) {
      managedEmployeeIDsWithJobs = {};
    }
    managedEmployeeIDsWithJobs = json['managedEmployeeIDsWithJobs'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['managedEmployeeIDsWithJobs'] = managedEmployeeIDsWithJobs;
    return data;
  }
}
