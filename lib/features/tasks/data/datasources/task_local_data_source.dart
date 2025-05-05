import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:taskify/core/error/exceptions.dart';
import 'package:taskify/features/tasks/data/models/task_model.dart';

abstract interface class TaskLocalDataSource {
  List<TaskModel> getAllTasks();

  void addTask(TaskModel task);

  void updateTask(TaskModel task);

  void deleteTask(String id);

  List<TaskModel> getFilteredTasks(String status);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box taskBox;

  TaskLocalDataSourceImpl({required this.taskBox});

  @override
  List<TaskModel> getAllTasks() {
    try {
      final tasks = <TaskModel>[];
      taskBox.read(() {
        for (int i = 0; i < taskBox.length; i++) {
          final jsonString = taskBox.getAt(i);
          final map = jsonDecode(jsonString) as Map<String, dynamic>;
          tasks.add(TaskModel.fromJson(map));
        }
      });
      return tasks;
    } catch (e) {
      throw LocalException('Failed to get tasks: ${e.toString()}');
    }
  }

  @override
  void addTask(TaskModel task) {
    try {
      final jsonString = jsonEncode(task.toJson());
      taskBox.write(() {
        taskBox.put(task.id, jsonString);
      });
    } catch (e) {
      throw LocalException('Failed to add task: ${e.toString()}');
    }
  }

  @override
  void updateTask(TaskModel task) {
    try {
      final index = _findTaskIndex(task.id);

      if (index != -1) {
        final jsonString = jsonEncode(task.toJson());
        taskBox.putAt(index, jsonString);
      } else {
        throw LocalException('Task not found with id: ${task.id}');
      }
    } catch (e) {
      throw LocalException('Failed to update task: ${e.toString()}');
    }
  }

  @override
  void deleteTask(String id) {
    try {
      final index = _findTaskIndex(id);

      if (index != -1) {
        taskBox.deleteAt(index);
      } else {
        throw LocalException('Task not found with id: $id');
      }
    } catch (e) {
      throw LocalException('Failed to delete task: ${e.toString()}');
    }
  }

  @override
  List<TaskModel> getFilteredTasks(String status) {
    try {
      final allTasks = getAllTasks();

      return allTasks.where((task) => task.status == status).toList();
    } catch (e) {
      throw LocalException('Failed to filter tasks: ${e.toString()}');
    }
  }

  int _findTaskIndex(String id) {
    for (int i = 0; i < taskBox.length; i++) {
      final jsonString = taskBox.getAt(i);

      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      if (map['id'] == id) {
        return i;
      }
    }
    return -1;
  }
}
