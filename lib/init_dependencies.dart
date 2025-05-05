import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/core/theme/theme_cubit.dart';
import 'package:taskify/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:taskify/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';
import 'package:taskify/features/tasks/domain/usecases/add_task.dart';
import 'package:taskify/features/tasks/domain/usecases/delete_task.dart';
import 'package:taskify/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:taskify/features/tasks/domain/usecases/get_filtered_tasks.dart';
import 'package:taskify/features/tasks/domain/usecases/update_task.dart';
import 'package:taskify/features/tasks/presentation/bloc/task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initTasks();
  final prefs = await SharedPreferences.getInstance();

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'tasks'));

  serviceLocator.registerLazySingleton(() => prefs);
  serviceLocator.registerLazySingleton(() => ThemeCubit(serviceLocator()));
}

void _initTasks() {
  //Data source
  serviceLocator
    ..registerFactory<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(taskBox: serviceLocator()),
    )
    //Repository
    ..registerFactory<TaskRepository>(
      () => TaskRepositoryImpl(localDataSource: serviceLocator()),
    )
    //Usecases
    ..registerFactory(() => AddTask(serviceLocator()))
    ..registerFactory(() => UpdateTask(serviceLocator()))
    ..registerFactory(() => GetAllTasks(serviceLocator()))
    ..registerFactory(() => GetFilteredTasks(serviceLocator()))
    ..registerFactory(() => DeleteTask(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => TaskBloc(
        getAllTasks: serviceLocator(),
        addTask: serviceLocator(),
        updateTask: serviceLocator(),
        deleteTask: serviceLocator(),
        getFilteredTasks: serviceLocator(),
      ),
    );
  ;
}
