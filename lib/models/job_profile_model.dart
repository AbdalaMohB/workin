import 'package:workin/models/developer_model.dart';
import 'package:workin/models/job_model.dart';

class JobProfileModel {
  final JobModel job;
  final DeveloperModel employee;

  const JobProfileModel({required this.job, required this.employee});
}
