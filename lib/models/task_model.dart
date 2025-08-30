class TaskModel {
  late String name;
  late String desc;
  late String ownerID;
  late String developerID;
  TaskModel({
    required this.name,
    required this.desc,
    required this.developerID,
    required this.ownerID,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    ownerID = json['ownerID'];
    developerID = json['developerID'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['desc'] = desc;
    data['ownerID'] = ownerID;
    data['developerID'] = developerID;
    return data;
  }
}
