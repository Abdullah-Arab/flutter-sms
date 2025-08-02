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
    ActionListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActionListScreen(),
      );
    },
    CategoryListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoryListScreen(),
      );
    },
    FormRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FormScreen(),
      );
    },
    ProviderListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProviderListScreen(),
      );
    },
  };
}

/// generated route for
/// [ActionListScreen]
class ActionListRoute extends PageRouteInfo<void> {
  const ActionListRoute({List<PageRouteInfo>? children})
      : super(
          ActionListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActionListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryListScreen]
class CategoryListRoute extends PageRouteInfo<void> {
  const CategoryListRoute({List<PageRouteInfo>? children})
      : super(
          CategoryListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FormScreen]
class FormRoute extends PageRouteInfo<void> {
  const FormRoute({List<PageRouteInfo>? children})
      : super(
          FormRoute.name,
          initialChildren: children,
        );

  static const String name = 'FormRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProviderListScreen]
class ProviderListRoute extends PageRouteInfo<void> {
  const ProviderListRoute({List<PageRouteInfo>? children})
      : super(
          ProviderListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProviderListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
