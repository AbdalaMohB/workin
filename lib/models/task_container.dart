import 'package:workin/models/developer_model.dart';
import 'package:workin/models/task_model.dart';

class TaskContainer {
  final TaskModel task;
  final DeveloperModel dev;
  const TaskContainer({required this.task, required this.dev});
}
