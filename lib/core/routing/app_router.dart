import 'package:auto_route/auto_route.dart';
import '../../features/sms_commands/presentation/screens/category_list_screen.dart';
import '../../features/sms_commands/presentation/screens/provider_list_screen.dart';
import '../../features/sms_commands/presentation/screens/action_list_screen.dart';
import '../../features/sms_commands/presentation/screens/form_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CategoryListRoute.page, initial: true),
    AutoRoute(page: ProviderListRoute.page),
    AutoRoute(page: ActionListRoute.page),
    AutoRoute(page: FormRoute.page),
  ];
}
