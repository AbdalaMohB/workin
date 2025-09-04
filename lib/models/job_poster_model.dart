import 'package:workin/models/job_model.dart';

class JobPosterModel {
  late String jobID;
  late String ownerID;
  late List<String> applicantIDs;
  late JobModel job;

  JobPosterModel({
    required this.ownerID,
    required this.applicantIDs,
    required this.job,
  });
  JobPosterModel.fromJson(Map<String, dynamic> json) {
    ownerID = json['ownerID'];
    applicantIDs = json['applicantIDs'].cast<String>();
    job = JobModel.fromJson(json['job']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['ownerID'] = ownerID;
    data['applicantIDs'] = applicantIDs;
    data['job'] = job.toJson();
    return data;
  }
}
