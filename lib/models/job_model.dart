class JobModel {
  late String jobName;
  late String jobDesc;
  late double rate;
  late bool isFullTime;
  JobModel({
    required this.jobName,
    required this.rate,
    required this.isFullTime,
    this.jobDesc = "",
  });

  JobModel.fromJson(Map<String, dynamic> json) {
    jobName = json['jobName'];
    jobDesc = json['jobDesc'];
    rate = json['rate'];
    isFullTime = json['isFullTime'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['rate'] = rate;
    data['jobName'] = jobName;
    data['jobDesc'] = jobDesc;
    data['isFullTime'] = isFullTime;
    return data;
  }
}
