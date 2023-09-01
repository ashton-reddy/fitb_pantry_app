import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_container.config.dart';

/// Generation command:
/// flutter packages pub run build_runner watch --delete-conflicting-outputs
final getIt = GetIt.instance;

@InjectableInit()
Future<void> initDi() {
  getIt.init();
  return getIt.allReady();
}