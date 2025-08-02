import 'package:get_it/get_it.dart';
import '../services/local_storage_service.dart';
import '../services/config_service.dart';
import '../../features/sms_commands/logic/sms_commands_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  // Services
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  getIt.registerLazySingleton<ConfigService>(() => ConfigService());

  // Cubits
  getIt.registerFactory<SmsCommandsCubit>(
    () => SmsCommandsCubit(getIt<ConfigService>()),
  );
}
