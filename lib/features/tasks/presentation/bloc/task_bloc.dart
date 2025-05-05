import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/usecase/usecase.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/domain/usecases/add_task.dart';
import 'package:taskify/features/tasks/domain/usecases/delete_task.dart';
import 'package:taskify/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:taskify/features/tasks/domain/usecases/get_filtered_tasks.dart';
import 'package:taskify/features/tasks/domain/usecases/update_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasks _getAllTasks;
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final GetFilteredTasks _getFilteredTasks;
  TaskBloc({
    required GetAllTasks getAllTasks,
    required AddTask addTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
    required GetFilteredTasks getFilteredTasks,
  }) : _getAllTasks = getAllTasks,
       _addTask = addTask,
       _updateTask = updateTask,
       _deleteTask = deleteTask,
       _getFilteredTasks = getFilteredTasks,
       super(TaskInitial()) {
    on<TaskEvent>((event, emit) {
      emit(TaskLoading());
    });
    on<GetAllTasksEvent>(_onGetAllTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<FilterTasksEvent>(_onFilterTasks);
  }

  void _onGetAllTasks(GetAllTasksEvent event, Emitter<TaskState> emit) {
    emit(TaskLoading());

    final result = _getAllTasks(NoParams());

    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskLoaded(tasks)),
    );
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskLoading());

    final params = TaskParams(
      id: event.id,
      title: event.title,
      description: event.description,
      priority: event.priority,
      status: event.status,
      dueDate: event.dueDate,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    );

    final result = _addTask(params);

    result.fold((failure) => emit(TaskError(failure.message)), (_) {
      emit(TaskOperationSuccess('Task added successfully'));
      add(GetAllTasksEvent());
    });
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskLoading());

    final params = TaskParams(
      id: event.id,
      title: event.title,
      description: event.description,
      priority: event.priority,
      status: event.status,
      dueDate: event.dueDate,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    );

    final result = _updateTask(params);

    result.fold((failure) => emit(TaskError(failure.message)), (_) {
      emit(TaskOperationSuccess('Task updated successfully'));
      add(GetAllTasksEvent());
    });
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskLoading());

    final result = _deleteTask(DeleteParams(event.id));

    result.fold((failure) => emit(TaskError(failure.message)), (_) {
      emit(TaskOperationSuccess('Task deleted successfully'));
      add(GetAllTasksEvent());
    });
  }

  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) {
    emit(TaskLoading());

    final result = _getFilteredTasks(FilterParams(event.status));

    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskLoaded(tasks)),
    );
  }
}
