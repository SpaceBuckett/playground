import 'package:get_it/get_it.dart';
import 'package:learning_ground/core/services/database_service.dart';

final locator = GetIt.instance;

void setupLocator() async {
  locator.registerSingleton(FirebaseDatabaseService());
}
