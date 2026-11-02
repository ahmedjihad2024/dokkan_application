import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';
import 'package:dokkan/core/services/storage_services/secure_storage_service.dart';
import 'package:dokkan/core/services/storage_services/shared_prefrences_service.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:dokkan/core/shared/data/api/category_api_service.dart';
import 'package:dokkan/core/shared/data/api/product_api_service.dart';
import 'package:dokkan/core/shared/data/data_source/category_remote_data_source.dart';
import 'package:dokkan/core/shared/data/data_source/product_remote_data_source.dart';
import 'package:dokkan/core/shared/data/repository/category_repository_impl.dart';
import 'package:dokkan/core/shared/data/repository/product_repository_impl.dart';
import 'package:dokkan/core/shared/domain/repository/category_repository.dart';
import 'package:dokkan/core/shared/domain/repository/product_repository.dart';
import 'package:dokkan/core/shared/domain/usecase/get_categories_usecase.dart';
import 'package:dokkan/core/shared/domain/usecase/get_products_usecase.dart';
import 'package:dokkan/features/authentication/data/api/auth_api_service.dart';
import 'package:dokkan/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:dokkan/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:dokkan/features/authentication/domain/repository/auth_repository.dart';
import 'package:dokkan/features/authentication/domain/usecase/login_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/register_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/resend_otp_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/verify_email_usecase.dart';
import 'package:dokkan/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:dokkan/features/home/data/api/home_api_service.dart';
import 'package:dokkan/features/home/data/data_source/home_remote_data_source.dart';
import 'package:dokkan/features/home/data/repository/home_repository_impl.dart';
import 'package:dokkan/features/home/domain/repository/home_repository.dart';
import 'package:dokkan/features/home/domain/usecase/get_offers_usecase.dart';
import 'package:dokkan/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ─── Storage Services ────────────────────────────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<SharedPrefsService>(
    () => SharedPrefsService(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<StorageService>(
    () => StorageService(sl<SecureStorageService>(), sl<SharedPrefsService>()),
  );

  // ─── Network (DioFactory & Dio) ─────────────────────────────────────────────
  sl.registerLazySingleton<DioFactory>(
    () => DioFactory(sl<StorageService>()),
  );
  sl.registerLazySingleton<Dio>(
    () => sl<DioFactory>().dio,
  );

  // ─── Authentication Feature ─────────────────────────────────────────────────
  sl.registerLazySingleton<AuthApiService>(
    () => AuthApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<AuthApiService>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<StorageService>(),
    ),
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
  sl.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(sl<AuthRepository>()),
  );

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      verifyEmailUseCase: sl<VerifyEmailUseCase>(),
      resendOtpUseCase: sl<ResendOtpUseCase>(),
    ),
  );

  // ─── Shared Categories Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<CategoryApiService>(
    () => CategoryApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(sl<CategoryApiService>()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<CategoryRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<CategoryRepository>()),
  );

  // ─── Shared Products Feature ────────────────────────────────────────────────
  sl.registerLazySingleton<ProductApiService>(
    () => ProductApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<ProductApiService>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(sl<ProductRepository>()),
  );

  // ─── Home Feature ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeApiService>(
    () => HomeApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<HomeApiService>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetOffersUseCase>(
    () => GetOffersUseCase(sl<HomeRepository>()),
  );

  sl.registerFactory<HomeCubit>(
    () => HomeCubit(
      getOffersUseCase: sl<GetOffersUseCase>(),
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getProductsUseCase: sl<GetProductsUseCase>(),
    ),
  );
}
