// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:scb_login/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:scb_login/features/auth/domain/usecases/login_use_case.dart';
import 'package:scb_login/features/auth/domain/usecases/offline_login_usecase.dart';
import 'package:scb_login/features/auth/presentation/cubit/login_cubit.dart';
import 'package:scb_login/features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Features - Auth

sl.registerFactory(() => LoginCubit(
  loginUseCase: sl(),
  offlineLoginUseCase: sl(),
));

sl.registerLazySingleton(() => LoginUseCase(sl()));
sl.registerLazySingleton(() => OfflineLoginUseCase(sl()));
sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

}
