import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:novel/screen/home_screen.dart';
import 'package:novel/screen/blood_pressure_info.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil은 앱 최상단에서 "한 번만" 초기화
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Figma 기준 사이즈
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        );
      },
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
      const HomeScreen(),
    ),
    GoRoute(
      path: '/blood-pressure/info',
      builder: (BuildContext context, GoRouterState state) =>
      const BloodPressureInfo(),
    ),
  ],
);
