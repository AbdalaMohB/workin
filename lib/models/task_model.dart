import 'package:hive/hive.dart';

part "task_model.g.dart";

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String desc;
  @HiveField(2)
  late String ownerID;
  @HiveField(3)
  late String developerID;
  TaskModel({
    required this.ownerID,
    required this.name,
    required this.desc,
    required this.developerID,
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

  @override
  bool operator ==(Object other) {
    if (other is TaskModel) {
      return ((ownerID == other.ownerID) &&
          (developerID == other.developerID) &&
          (desc == other.desc) &&
          (name == other.name));
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(developerID, ownerID, name, desc);
}
