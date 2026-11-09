import 'package:dokkan/core/services/hive_services/adapter/hive_registrar.g.dart';
import 'package:dokkan/features/favorites/data/response/response.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<Favorite>('favorites');
}
