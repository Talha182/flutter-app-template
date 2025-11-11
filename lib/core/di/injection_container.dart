import 'package:get_it/get_it.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../network/api_client.dart';
import '../../common/services/database_service.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 🔹 Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // 🔹 Database
  final dbService = DatabaseService();
  await dbService.init();
  sl.registerLazySingleton<DatabaseService>(() => dbService);

  // 🔹 Repositories
  sl.registerLazySingleton<TasksRepository>(
        () => TasksRepositoryImpl(databaseService: sl()),
  );
}