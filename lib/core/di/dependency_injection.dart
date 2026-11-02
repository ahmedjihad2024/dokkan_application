import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';
import 'package:dokkan/core/services/storage_services/secure_storage_service.dart';
import 'package:dokkan/core/services/storage_services/shared_prefrences_service.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:dokkan/features/authentication/data/api/auth_api_service.dart';
import 'package:dokkan/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:dokkan/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:dokkan/features/authentication/domain/repository/auth_repository.dart';
import 'package:dokkan/features/authentication/domain/usecase/login_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/register_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/verify_email_usecase.dart';
import 'package:dokkan/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Storage Services
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  sl.registerLazySingleton<SharedPrefsService>(
    () => SharedPrefsService(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<StorageService>(
    () => StorageService(sl<SecureStorageService>(), sl<SharedPrefsService>()),
  );

  // Network
  sl.registerLazySingleton<DioFactory>(() => DioFactory(sl<StorageService>()));

  sl.registerLazySingleton<Dio>(() => sl<DioFactory>().dio);

  // Authentication
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(sl<Dio>()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<AuthApiService>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>(), sl<StorageService>()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<VerifyEmailUseCase>(
    () => VerifyEmailUseCase(sl<AuthRepository>()),
  );

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      verifyEmailUseCase: sl<VerifyEmailUseCase>(),
    ),
  );
}
