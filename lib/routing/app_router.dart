import 'package:auto_route/auto_route.dart';
import 'package:fitb_pantry_app/pages/startup_page/startup_page.dart';
import 'package:fitb_pantry_app/pages/login_page/login_page.dart';
import 'package:fitb_pantry_app/pages/order_page/order_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: StartupRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: OrderRoute.page,
        ),
      ];
}
