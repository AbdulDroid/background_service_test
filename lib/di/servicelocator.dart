import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/navigationservice.dart';

import '../data/local/preferences.dart';
import '../data/remote/auth/authapiservice.dart';
import '../data/remote/auth/authrepositroy.dart';
import '../data/remote/newborn/newbornapiservice.dart';
import '../data/remote/newborn/newbornrepository.dart';

final getIT = GetIt.instance;

Future<void> initialize() async {
  final prefs = await SharedPreferences.getInstance();

  getIT.registerSingleton(prefs);

  ///Navigation
  getIT.registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());

  ///ApiService
  getIT.registerLazySingleton<AuthApiService>(
      () => AuthApiServiceImpl(prefs: getIT()));
  getIT.registerLazySingleton<NewBornApiService>(
      () => NewBornApiServiceImpl(prefs: getIT()));

  ///Repository
  getIT.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: getIT()));
  getIT.registerLazySingleton<NewBornRepository>(
      () => NewBornRepositoryImpl(apiService: getIT()));

  /// Locale Cache
  getIT.registerLazySingleton<Preferences>(
      () => PreferencesImpl(prefs: getIT()));
}
