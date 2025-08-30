import 'package:workin/models/user_model.dart';

class OwnerModel extends UserModel {
  late String companyName;
  late List<String> candidateIds;
  OwnerModel({
    required this.companyName,
    required super.name,
    super.monthlyRate,
    super.hourlyRate,
    super.isOwner = true,
  }) {
    candidateIds = [];
  }

  OwnerModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    companyName = json['companyName'];
    candidateIds = json['candidateIds'].cast<String>();
    isOwner = true;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = super.toJson();
    data['companyName'] = companyName;
    data['candidateIds'] = candidateIds;
    return data;
  }
}
