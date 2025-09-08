import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workin/models/task_local_model.dart';
import 'package:workin/models/task_model.dart';

class HiveService {
  static HiveService instance = HiveService._internal();
  HiveService._internal();

  late Box<TaskLocalModel> _box;

  Future<void> init() async {
    var filepath = await getApplicationDocumentsDirectory();
    Hive.registerAdapter(TaskLocalModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    _box = await Hive.openBox("tasks", path: filepath.path);
  }

  List<TaskLocalModel> get tasks => _box.values.toList();
  Future<void> addTask(TaskLocalModel task) async {
    await _box.add(task);
  }

  Future<void> cacheTasks(List<TaskLocalModel> tasks) async {
    for (TaskLocalModel task in tasks) {
      if (!(_box.values.contains(task))) {
        await _box.add(task);
      }
    }
  }

  bool taskExists(TaskLocalModel task) {
    return _box.values.contains(task);
  }

  Future<void> editTask(TaskLocalModel task, int index) async {
    await _box.putAt(index, task);
  }

  Future<void> deleteTask(int index) async {
    await _box.deleteAt(index);
  }
}
