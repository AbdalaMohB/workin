import 'package:workin/models/user_model.dart';

class DeveloperModel extends UserModel {
  late String job;
  late int yearsOfExperience;
  late String? cv;

  DeveloperModel._internal({
    required super.name,
    required this.job,
    required this.yearsOfExperience,
    required this.cv,
    required super.monthlyRate,
    required super.hourlyRate,
    super.isOwner = false,
  });
  DeveloperModel.partTime({
    required String name,
    required String job,
    required int yearsOfExperience,
    required int hourlyRate,
    String? cv,
    List<String>? employedBy,
  }) : this._internal(
         name: name,
         job: job,
         yearsOfExperience: yearsOfExperience,
         cv: cv,
         monthlyRate: null,
         hourlyRate: hourlyRate,
       );
  DeveloperModel({
    required String name,
    required String job,
    required int yearsOfExperience,
    required int monthlyRate,
    String? cv,
    List<String>? candidateTo,
    List<String>? employedBy,
  }) : this._internal(
         name: name,
         job: job,
         yearsOfExperience: yearsOfExperience,
         cv: cv,
         monthlyRate: monthlyRate,
         hourlyRate: null,
       );
  DeveloperModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json.containsKey('cv')) {
      cv = json['cv'];
    } else {
      cv = null;
    }
    job = json['job'];
    yearsOfExperience = json['yearsOfExperience'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['job'] = job;
    data['cv'] = cv;
    data['yearsOfExperience'] = yearsOfExperience;
    return data;
  }
}
