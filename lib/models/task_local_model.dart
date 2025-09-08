import 'package:hive/hive.dart';
import 'package:workin/models/task_container.dart';
import 'package:workin/models/task_model.dart';

part "task_local_model.g.dart";

@HiveType(typeId: 2)
class TaskLocalModel {
  @HiveField(0)
  final TaskModel task;
  @HiveField(1)
  final String assignee;

  const TaskLocalModel._internal({required this.task, required this.assignee});
  const TaskLocalModel({required this.task, required this.assignee});
  TaskLocalModel.fromContainer(TaskContainer container)
    : this._internal(task: container.task, assignee: container.dev.name);

  @override
  bool operator ==(Object other) {
    if (other is TaskLocalModel) {
      return ((assignee == other.assignee) &&
          (task.developerID == other.task.developerID) &&
          (task.name == other.task.name) &&
          (task.ownerID == other.task.ownerID) &&
          (task.desc == other.task.desc));
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(
    assignee,
    task.developerID,
    task.desc,
    task.ownerID,
    task.name,
  );
}
