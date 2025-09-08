// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskLocalModelAdapter extends TypeAdapter<TaskLocalModel> {
  @override
  final int typeId = 2;

  @override
  TaskLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskLocalModel(
      task: fields[0] as TaskModel,
      assignee: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.assignee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
