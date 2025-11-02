import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance; // service locator

Future<void> initDependencies() async {
  // 🔹 Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // 🔹 Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // 🔹 Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remote: sl()),
  );

  // You can later add more like:
  // sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(remote: sl()));
}
