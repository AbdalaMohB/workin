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
    super.isOwner = false,
  });
  DeveloperModel({
    required String name,
    required String job,
    required int yearsOfExperience,
    String? cv,
    List<String>? candidateTo,
  }) : this._internal(
         name: name,
         job: job,
         yearsOfExperience: yearsOfExperience,
         cv: cv,
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
