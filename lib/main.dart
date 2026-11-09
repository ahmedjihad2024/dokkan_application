import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/core/services/hive_services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();
  await setupServiceLocator();

  // Set edge-to-edge transparent system overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(const DokkanApp());
}



/// update the hive models for 
// dart run build_runner build --delete-conflicting-outputs

/// for update the supabase_schema.g.dart of supabase
// npx supabase gen types --lang dart --remote | Out-File -FilePath lib/core/network/supabase_schema.g.dart -Encoding utf8