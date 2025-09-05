import 'package:workin/models/user_model.dart';

class OwnerModel extends UserModel {
  late String companyName;
  OwnerModel({
    required this.companyName,
    required super.name,
    super.monthlyRate,
    super.hourlyRate,
    super.isOwner = true,
  });

  OwnerModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    companyName = json['companyName'];
    isOwner = true;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = super.toJson();
    data['companyName'] = companyName;
    return data;
  }
}
