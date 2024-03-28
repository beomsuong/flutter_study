import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/home_screen/home_screen.dart';
import 'package:fmdakgg/main_screen.dart';
import 'package:fmdakgg/player_search/player_search.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages('ko', timeago.KoMessages());

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'player/:nickname',
            builder: (BuildContext context, GoRouterState state) {
              return PlayerSearch(
                nickname: state.pathParameters['nickname'] as String,
              );
            }),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
