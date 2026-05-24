import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_cubit.dart';
import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_cubit.dart';
import 'package:admin_msar/src/features/ads/data/datasources/ads_remote_data_source.dart';
import 'package:admin_msar/src/features/ads/data/repositories/ads_repository_impl.dart';
import 'package:admin_msar/src/features/ads/domain/repositories/ads_repository.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/create_ad_use_case.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/delete_ad_use_case.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/get_ads_use_case.dart';
import 'package:admin_msar/src/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:admin_msar/src/features/auth/login/data/datasources/auth_remote_data_source.dart';
import 'package:admin_msar/src/features/auth/login/data/repositories/auth_repository_impl.dart';
import 'package:admin_msar/src/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:admin_msar/src/features/auth/login/domain/use_cases/get_current_admin_use_case.dart';
import 'package:admin_msar/src/features/auth/login/domain/use_cases/sign_in_use_case.dart';
import 'package:admin_msar/src/features/auth/login/domain/use_cases/sign_out_use_case.dart';
import 'package:admin_msar/src/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_cubit.dart';
import 'package:admin_msar/src/features/home/domain/use_cases/watch_home_stats_use_case.dart';
import 'package:admin_msar/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:admin_msar/src/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:admin_msar/src/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';
import 'package:admin_msar/src/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:admin_msar/src/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:admin_msar/src/features/posts/domain/use_cases/get_posts_use_case.dart';
import 'package:admin_msar/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:admin_msar/src/features/users/data/datasources/users_remote_data_source.dart';
import 'package:admin_msar/src/features/users/data/repositories/users_repository_impl.dart';
import 'package:admin_msar/src/features/users/domain/repositories/users_repository.dart';
import 'package:admin_msar/src/features/users/domain/use_cases/delete_user_use_case.dart';
import 'package:admin_msar/src/features/users/domain/use_cases/get_users_use_case.dart';
import 'package:admin_msar/src/features/users/presentation/cubit/users_cubit.dart';

final getIt = GetIt.instance;

void setupInjector() {
  // External services
  getIt
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

  // Auth
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        firebaseAuth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
    )
    ..registerFactory<SignInUseCase>(() => SignInUseCase(getIt()))
    ..registerFactory<SignOutUseCase>(() => SignOutUseCase(getIt()))
    ..registerFactory<GetCurrentAdminUseCase>(
      () => GetCurrentAdminUseCase(getIt()),
    )
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
    ..registerLazySingleton<AuthSessionCubit>(
      () => AuthSessionCubit(repository: getIt(), signOut: getIt()),
    );

  // Users
  getIt
    ..registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSource(getIt<FirebaseFirestore>()),
    )
    ..registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImpl(getIt<UsersRemoteDataSource>()),
    )
    ..registerFactory<GetUsersUseCase>(() => GetUsersUseCase(getIt()))
    ..registerFactory<DeleteUserUseCase>(() => DeleteUserUseCase(getIt()))
    ..registerFactory<UsersCubit>(
      () => UsersCubit(getUsers: getIt(), deleteUser: getIt()),
    );

  // Posts
  getIt
    ..registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSource(getIt<FirebaseFirestore>()),
    )
    ..registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(getIt<PostsRemoteDataSource>()),
    )
    ..registerFactory<GetPostsUseCase>(() => GetPostsUseCase(getIt()))
    ..registerFactory<DeletePostUseCase>(() => DeletePostUseCase(getIt()))
    ..registerFactory<CreatePostUseCase>(() => CreatePostUseCase(getIt()))
    ..registerFactory<PostsCubit>(
      () => PostsCubit(getPosts: getIt(), deletePost: getIt()),
    )
    ..registerFactory<AddPostCubit>(() => AddPostCubit(getIt()));

  // Ads
  getIt
    ..registerLazySingleton<AdsRemoteDataSource>(
      () => AdsRemoteDataSource(getIt<FirebaseFirestore>()),
    )
    ..registerLazySingleton<AdsRepository>(
      () => AdsRepositoryImpl(getIt<AdsRemoteDataSource>()),
    )
    ..registerFactory<GetAdsUseCase>(() => GetAdsUseCase(getIt()))
    ..registerFactory<DeleteAdUseCase>(() => DeleteAdUseCase(getIt()))
    ..registerFactory<CreateAdUseCase>(() => CreateAdUseCase(getIt()))
    ..registerFactory<AdsCubit>(
      () => AdsCubit(getAds: getIt(), deleteAd: getIt()),
    )
    ..registerFactory<AddAdsCubit>(() => AddAdsCubit(getIt()));

  // Home
  getIt
    ..registerFactory<WatchHomeStatsUseCase>(
      () => WatchHomeStatsUseCase(
        users: getIt<UsersRepository>(),
        posts: getIt<PostsRepository>(),
        ads: getIt<AdsRepository>(),
      ),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
