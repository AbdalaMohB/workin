class UserModel {
  late String name;
  int? monthlyRate;
  int? hourlyRate;
  late bool isOwner;
  UserModel({
    required this.name,
    this.monthlyRate,
    this.hourlyRate,
    required this.isOwner,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('monthlyRate')) {
      json['monthlyRate'] = null;
    }
    if (!json.containsKey('hourlyRate')) {
      json['hourlyRate'] = null;
    }
    name = json['name'];
    isOwner = json['isOwner'];
    monthlyRate = json['monthlyRate'];
    hourlyRate = json['hourlyRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['isOwner'] = isOwner;
    data['monthlyRate'] = monthlyRate;
    data['hourlyRate'] = hourlyRate;
    return data;
  }
}
