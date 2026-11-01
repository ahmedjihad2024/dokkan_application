import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'res/router/app_router.dart';
import 'res/router/routes.dart';
import 'res/theme_manager.dart';
import 'theme/theme_cubit.dart';

// Global keys matching clean architecture pattern from otlob
// ignore: non_constant_identifier_names
final GlobalKey<ScaffoldMessengerState> SCAFFOLD_MESSENGER_KEY =
    GlobalKey<ScaffoldMessengerState>();
// ignore: non_constant_identifier_names
final GlobalKey<NavigatorState> NAVIGATOR_KEY = GlobalKey<NavigatorState>();

class DokkanApp extends StatelessWidget {
  const DokkanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          // Standard Figma design canvas size (390 x 844)
          return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Dokkan Atelier',
                debugShowCheckedModeBanner: false,
                navigatorKey: NAVIGATOR_KEY,
                scaffoldMessengerKey: SCAFFOLD_MESSENGER_KEY,
                theme: ThemeManager.lightTheme(context),
                darkTheme: ThemeManager.darkTheme(context),
                themeMode: themeMode,
                initialRoute: Routes.home,
                onGenerateInitialRoutes: (initialRoute) => [
                  RouteGenerator.getRoute(RouteSettings(name: initialRoute)),
                ],
                onGenerateRoute: RouteGenerator.getRoute,
              );
            },
          );
        },
      ),
    );
  }
}
