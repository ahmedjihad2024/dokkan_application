import 'package:dokkan/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth/app_auth_cubit.dart';
import 'di/dependency_injection.dart';
import 'res/router/app_router.dart';
import 'res/router/routes.dart';
import 'res/theme_manager.dart';
import 'theme/theme_cubit.dart';

// ignore: non_constant_identifier_names
final GlobalKey<ScaffoldMessengerState> SCAFFOLD_MESSENGER_KEY =
    GlobalKey<ScaffoldMessengerState>();
// ignore: non_constant_identifier_names
final GlobalKey<NavigatorState> NAVIGATOR_KEY = GlobalKey<NavigatorState>();

class DokkanApp extends StatelessWidget {
  const DokkanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider.value(value: sl<AppAuthCubit>()),
        BlocProvider(create: (_) => sl<FavoritesCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return BlocListener<AppAuthCubit, AuthStatus>(
                listenWhen: (previous, current) =>
                    current == AuthStatus.unauthenticated,
                listener: (context, state) {
                  NAVIGATOR_KEY.currentState?.pushNamedAndRemoveUntil(
                    Routes.login,
                    (route) => false,
                  );
                },
                child: MaterialApp(
                  title: 'Dokkan Atelier',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: NAVIGATOR_KEY,
                  scaffoldMessengerKey: SCAFFOLD_MESSENGER_KEY,
                  theme: ThemeManager.lightTheme(context),
                  darkTheme: ThemeManager.darkTheme(context),
                  themeMode: themeMode,
                  initialRoute: Routes.splash,
                  onGenerateInitialRoutes: (initialRoute) => [
                    RouteGenerator.getRoute(RouteSettings(name: initialRoute)),
                  ],
                  onGenerateRoute: RouteGenerator.getRoute,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
