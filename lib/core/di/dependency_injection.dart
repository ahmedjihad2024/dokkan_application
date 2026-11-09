import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:dokkan/core/auth/app_auth_cubit.dart';
import 'package:dokkan/core/config/constants.dart';
import 'package:dokkan/core/network/dio_factory.dart';
import 'package:dokkan/core/services/storage_services/secure_storage_service.dart';
import 'package:dokkan/core/services/storage_services/shared_prefrences_service.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:dokkan/core/shared/data/api/add_to_cart_api_service.dart';
import 'package:dokkan/core/shared/data/api/product_api_service.dart';
import 'package:dokkan/core/shared/data/api/review_api_service.dart';
import 'package:dokkan/core/shared/data/data_source/add_to_cart_remote_data_source.dart';
import 'package:dokkan/core/shared/data/data_source/product_remote_data_source.dart';
import 'package:dokkan/core/shared/data/data_source/review_remote_data_source.dart';
import 'package:dokkan/core/shared/data/repository/add_to_cart_repository_impl.dart';
import 'package:dokkan/core/shared/data/repository/product_repository_impl.dart';
import 'package:dokkan/core/shared/data/repository/review_repository_impl.dart';
import 'package:dokkan/core/shared/data/api/refresh_token_api_service.dart';
import 'package:dokkan/core/shared/data/data_source/refresh_token_remote_data_source.dart';
import 'package:dokkan/core/shared/data/repository/refresh_token_repository_impl.dart';
import 'package:dokkan/core/shared/domain/repository/refresh_token_repository.dart';
import 'package:dokkan/core/shared/domain/usecase/refresh_token_usecase.dart';
import 'package:dokkan/core/shared/domain/repository/add_to_cart_repository.dart';
import 'package:dokkan/core/shared/domain/repository/product_repository.dart';
import 'package:dokkan/core/shared/domain/repository/review_repository.dart';
import 'package:dokkan/core/shared/domain/usecase/add_to_cart_usecase.dart';
import 'package:dokkan/core/shared/domain/usecase/get_products_usecase.dart';
import 'package:dokkan/core/shared/domain/usecase/get_reviews_usecase.dart';
import 'package:dokkan/features/favorites/data/database/favorite_db_service.dart';
import 'package:dokkan/features/favorites/data/data_source/favorite_local_data_source.dart';
import 'package:dokkan/features/favorites/data/repository/favorites_repository_impl.dart';
import 'package:dokkan/features/favorites/data/response/response.dart';
import 'package:dokkan/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dokkan/features/favorites/domain/usecase/add_to_favorites_usecase.dart';
import 'package:dokkan/features/favorites/domain/usecase/get_favorites_usecase.dart';
import 'package:dokkan/features/favorites/domain/usecase/is_favorite_usecase.dart';
import 'package:dokkan/features/favorites/domain/usecase/remove_from_favorites_usecase.dart';
import 'package:dokkan/features/favorites/domain/usecase/toggle_favorite_usecase.dart';
import 'package:dokkan/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:dokkan/features/authentication/data/api/auth_api_service.dart';
import 'package:dokkan/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:dokkan/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:dokkan/features/authentication/domain/repository/auth_repository.dart';
import 'package:dokkan/features/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/login_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/register_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/resend_otp_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/reset_password_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/validate_otp_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/verify_email_usecase.dart';
import 'package:dokkan/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:dokkan/features/cart/data/api/cart_api_service.dart';
import 'package:dokkan/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:dokkan/features/cart/data/repository/cart_repository_impl.dart';
import 'package:dokkan/features/cart/domain/repository/cart_repository.dart';
import 'package:dokkan/features/cart/domain/usecase/add_cart_item_usecase.dart';
import 'package:dokkan/features/cart/domain/usecase/decrement_cart_item_usecase.dart';
import 'package:dokkan/features/cart/domain/usecase/delete_cart_item_usecase.dart';
import 'package:dokkan/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:dokkan/features/cart/domain/usecase/update_cart_item_usecase.dart';
import 'package:dokkan/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:dokkan/features/checkout/data/api/address_api_service.dart';
import 'package:dokkan/features/checkout/data/data_source/address_remote_data_source.dart';
import 'package:dokkan/features/checkout/data/repository/address_repository_impl.dart';
import 'package:dokkan/features/checkout/domain/repository/address_repository.dart';
import 'package:dokkan/features/checkout/domain/usecase/create_address_usecase.dart';
import 'package:dokkan/features/checkout/domain/usecase/delete_address_usecase.dart';
import 'package:dokkan/features/checkout/domain/usecase/get_addresses_usecase.dart';
import 'package:dokkan/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:dokkan/features/edit_address/data/api/edit_address_api_service.dart';
import 'package:dokkan/features/edit_address/data/data_source/edit_address_remote_data_source.dart';
import 'package:dokkan/features/edit_address/data/repository/edit_address_repository_impl.dart';
import 'package:dokkan/features/edit_address/domain/repository/edit_address_repository.dart';
import 'package:dokkan/features/edit_address/domain/usecase/create_address_usecase.dart' as edit_address_create;
import 'package:dokkan/features/edit_address/domain/usecase/get_address_by_id_usecase.dart';
import 'package:dokkan/features/edit_address/domain/usecase/update_address_usecase.dart';
import 'package:dokkan/features/edit_address/presentation/cubit/edit_address_cubit.dart';
import 'package:dokkan/features/home/data/api/home_api_service.dart';
import 'package:dokkan/features/home/data/data_source/home_remote_data_source.dart';
import 'package:dokkan/features/home/data/repository/home_repository_impl.dart';
import 'package:dokkan/features/home/domain/repository/home_repository.dart';
import 'package:dokkan/features/home/domain/usecase/get_offers_usecase.dart';
import 'package:dokkan/features/home/presentation/cubit/home_cubit.dart';
import 'package:dokkan/features/product_details/data/api/product_details_api_service.dart';
import 'package:dokkan/features/product_details/data/data_source/product_details_remote_data_source.dart';
import 'package:dokkan/features/product_details/data/repository/product_details_repository_impl.dart';
import 'package:dokkan/features/product_details/domain/repository/product_details_repository.dart';
import 'package:dokkan/features/product_details/domain/usecase/get_product_details_usecase.dart';
import 'package:dokkan/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:dokkan/features/search/presentation/cubit/search_cubit.dart';
import 'package:dokkan/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await sl.reset();
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

  // ─── Global Auth Session State ───────────────────────────────────────────────
  final storageService = sl<StorageService>();
  final hasTokens = await storageService.hasRefreshToken() ||
      await storageService.hasAccessToken();
  sl.registerLazySingleton<AppAuthCubit>(
    () => AppAuthCubit(
      hasTokens ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    ),
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
  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<ValidateOtpUseCase>(
    () => ValidateOtpUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(sl<AuthRepository>()),
  );

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      verifyEmailUseCase: sl<VerifyEmailUseCase>(),
      resendOtpUseCase: sl<ResendOtpUseCase>(),
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      validateOtpUseCase: sl<ValidateOtpUseCase>(),
      resetPasswordUseCase: sl<ResetPasswordUseCase>(),
    ),
  );


  // ─── Shared Products Feature ─────────────────────────────────────────────────
  sl.registerLazySingleton<ProductApiService>(
    () => ProductApiServiceImpl(sl<DioFactory>()),
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

  // ─── Shared Reviews Feature ─────────────────────────────────────────────────
  sl.registerLazySingleton<ReviewApiService>(
    () => ReviewApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(sl<ReviewApiService>()),
  );
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(sl<ReviewRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetReviewsUseCase>(
    () => GetReviewsUseCase(sl<ReviewRepository>()),
  );

  // ─── Shared Add To Cart Feature ─────────────────────────────────────────────
  sl.registerLazySingleton<AddToCartApiService>(
    () => AddToCartApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<AddToCartRemoteDataSource>(
    () => AddToCartRemoteDataSourceImpl(sl<AddToCartApiService>()),
  );
  sl.registerLazySingleton<AddToCartRepository>(
    () => AddToCartRepositoryImpl(sl<AddToCartRemoteDataSource>()),
  );
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(sl<AddToCartRepository>()),
  );

  // ─── Favorites Feature ─────────────────────────────────────────────────────
  sl.registerLazySingleton<Box<Favorite>>(
    () => Hive.box<Favorite>('favorites'),
  );
  sl.registerLazySingleton<FavoriteDbService>(
    () => FavoriteDbServiceImpl(sl<Box<Favorite>>()),
  );
  sl.registerLazySingleton<FavoriteLocalDataSource>(
    () => FavoriteLocalDataSourceImpl(sl<FavoriteDbService>()),
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(sl<FavoriteLocalDataSource>()),
  );
  sl.registerLazySingleton<AddToFavoritesUseCase>(
    () => AddToFavoritesUseCase(sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<RemoveFromFavoritesUseCase>(
    () => RemoveFromFavoritesUseCase(sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<IsFavoriteUseCase>(
    () => IsFavoriteUseCase(sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(sl<FavoritesRepository>()),
  );

  // ─── Shared Refresh Token Feature ───────────────────────────────────────────
  sl.registerLazySingleton<RefreshTokenApiService>(
    () => RefreshTokenApiServiceImpl(
      Dio(
        BaseOptions(
          baseUrl: Constants.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          headers: {
            APPLICATION_JSON: APPLICATION_JSON,
            CONTENT_TYPE: APPLICATION_JSON,
            ACCEPT: APPLICATION_JSON,
          },
        ),
      ),
    ),
  );
  sl.registerLazySingleton<RefreshTokenRemoteDataSource>(
    () => RefreshTokenRemoteDataSourceImpl(sl<RefreshTokenApiService>()),
  );
  sl.registerLazySingleton<RefreshTokenRepository>(
    () => RefreshTokenRepositoryImpl(sl<RefreshTokenRemoteDataSource>()),
  );
  sl.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(sl<RefreshTokenRepository>()),
  );

  // ─── Cart Feature ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<CartApiService>(
    () => CartApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(sl<CartApiService>()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl<CartRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<AddCartItemUseCase>(
    () => AddCartItemUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<UpdateCartItemUseCase>(
    () => UpdateCartItemUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<DecrementCartItemUseCase>(
    () => DecrementCartItemUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<DeleteCartItemUseCase>(
    () => DeleteCartItemUseCase(sl<CartRepository>()),
  );
  sl.registerFactory<CartCubit>(
    () => CartCubit(
      sl<GetCartUseCase>(),
      sl<UpdateCartItemUseCase>(),
      sl<DecrementCartItemUseCase>(),
      sl<DeleteCartItemUseCase>(),
    ),
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
      getProductsUseCase: sl<GetProductsUseCase>(),
      addToCartUseCase: sl<AddToCartUseCase>(),
    ),
  );

  // ─── Product Details Feature ───────────────────────────────────────────────
  sl.registerLazySingleton<ProductDetailsApiService>(
    () => ProductDetailsApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(sl<ProductDetailsApiService>()),
  );
  sl.registerLazySingleton<ProductDetailsRepository>(
    () => ProductDetailsRepositoryImpl(sl<ProductDetailsRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(sl<ProductDetailsRepository>()),
  );
  sl.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(
      getProductDetailsUseCase: sl<GetProductDetailsUseCase>(),
      getReviewsUseCase: sl<GetReviewsUseCase>(),
      addToCartUseCase: sl<AddToCartUseCase>(),
    ),
  );

  // ─── Checkout / Addresses Feature ──────────────────────────────────────────
  sl.registerLazySingleton<AddressApiService>(
    () => AddressApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImpl(sl<AddressApiService>()),
  );
  sl.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(sl<AddressRemoteDataSource>()),
  );
  sl.registerLazySingleton<CreateAddressUseCase>(
    () => CreateAddressUseCase(sl<AddressRepository>()),
  );
  sl.registerLazySingleton<GetAddressesUseCase>(
    () => GetAddressesUseCase(sl<AddressRepository>()),
  );
  sl.registerLazySingleton<DeleteAddressUseCase>(
    () => DeleteAddressUseCase(sl<AddressRepository>()),
  );
  sl.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      getAddressesUseCase: sl<GetAddressesUseCase>(),
      createAddressUseCase: sl<CreateAddressUseCase>(),
      deleteAddressUseCase: sl<DeleteAddressUseCase>(),
      getCartUseCase: sl<GetCartUseCase>(),
    ),
  );

  // ─── Edit Address Feature ──────────────────────────────────────────────────
  sl.registerLazySingleton<EditAddressApiService>(
    () => EditAddressApiServiceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<EditAddressRemoteDataSource>(
    () => EditAddressRemoteDataSourceImpl(sl<EditAddressApiService>()),
  );
  sl.registerLazySingleton<EditAddressRepository>(
    () => EditAddressRepositoryImpl(sl<EditAddressRemoteDataSource>()),
  );
  sl.registerLazySingleton<UpdateAddressUseCase>(
    () => UpdateAddressUseCase(sl<EditAddressRepository>()),
  );
  sl.registerLazySingleton<GetAddressByIdUseCase>(
    () => GetAddressByIdUseCase(sl<EditAddressRepository>()),
  );
  sl.registerLazySingleton<edit_address_create.CreateAddressUseCase>(
    () => edit_address_create.CreateAddressUseCase(sl<EditAddressRepository>()),
  );
  sl.registerFactory<EditAddressCubit>(
    () => EditAddressCubit(
      createAddressUseCase: sl<edit_address_create.CreateAddressUseCase>(),
      updateAddressUseCase: sl<UpdateAddressUseCase>(),
    ),
  );

  // ─── Reviews Feature ───────────────────────────────────────────────────────
  sl.registerFactory<ReviewsCubit>(
    () => ReviewsCubit(
      getReviewsUseCase: sl<GetReviewsUseCase>(),
    ),
  );
  // ─── Search Feature ────────────────────────────────────────────────────────
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(
      getProductsUseCase: sl<GetProductsUseCase>(),
      addToCartUseCase: sl<AddToCartUseCase>(),
    ),
  );

  // ─── Favorites Feature ─────────────────────────────────────────────────────
  sl.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(
      getFavoritesUseCase: sl<GetFavoritesUseCase>(),
      removeFromFavoritesUseCase: sl<RemoveFromFavoritesUseCase>(),
      addToCartUseCase: sl<AddToCartUseCase>(),
      isFavoriteUseCase: sl<IsFavoriteUseCase>(),
      toggleFavoriteUseCase: sl<ToggleFavoriteUseCase>(),
    ),
  );
}