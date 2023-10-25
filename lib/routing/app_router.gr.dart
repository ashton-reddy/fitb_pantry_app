// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    OrderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    StartupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StartupPage(),
      );
    },
    OrderSummaryRoute.name: (routeData) {
      final args = routeData.argsAs<OrderSummaryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderSummaryPage(
          key: args.key,
          orderList: args.orderList,
        ),
      );
    },
    CompletedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CompletedPage(),
      );
    },
  };
}

/// generated route for
/// [OrderPage]
class OrderRoute extends PageRouteInfo<void> {
  const OrderRoute({List<PageRouteInfo>? children})
      : super(
          OrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StartupPage]
class StartupRoute extends PageRouteInfo<void> {
  const StartupRoute({List<PageRouteInfo>? children})
      : super(
          StartupRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderSummaryPage]
class OrderSummaryRoute extends PageRouteInfo<OrderSummaryRouteArgs> {
  OrderSummaryRoute({
    Key? key,
    required List<GroupModel> orderList,
    List<PageRouteInfo>? children,
  }) : super(
          OrderSummaryRoute.name,
          args: OrderSummaryRouteArgs(
            key: key,
            orderList: orderList,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderSummaryRoute';

  static const PageInfo<OrderSummaryRouteArgs> page =
      PageInfo<OrderSummaryRouteArgs>(name);
}

class OrderSummaryRouteArgs {
  const OrderSummaryRouteArgs({
    this.key,
    required this.orderList,
  });

  final Key? key;

  final List<GroupModel> orderList;

  @override
  String toString() {
    return 'OrderSummaryRouteArgs{key: $key, orderList: $orderList}';
  }
}

/// generated route for
/// [CompletedPage]
class CompletedRoute extends PageRouteInfo<void> {
  const CompletedRoute({List<PageRouteInfo>? children})
      : super(
          CompletedRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
