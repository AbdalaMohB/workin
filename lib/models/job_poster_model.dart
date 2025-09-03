class JobPosterModel {
  late String jobID;
  late String ownerID;
  late List<String> applicantIDs;
  late String jobName;

  JobPosterModel({
    required this.ownerID,
    required this.applicantIDs,
    required this.jobName,
  });
  JobPosterModel.fromJson(Map<String, dynamic> json) {
    ownerID = json['ownerID'];
    applicantIDs = json['applicantIDs'].cast<String>();
    jobName = json['jobName'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['ownerID'] = ownerID;
    data['jobName'] = jobName;
    data['applicantIDs'] = applicantIDs;
    return data;
  }
}
