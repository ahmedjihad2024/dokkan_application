// lib/hive/hive_adapters.dart
import 'package:dokkan/features/favorites/data/response/response.dart';
import 'package:hive_ce/hive.dart';

@GenerateAdapters([AdapterSpec<Favorite>()])
part 'adapter.g.dart';
