import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/fetch_database/fetch_database_cubit.dart';
import 'package:mmt_mobile/common_widget/text_widget.dart';
import 'package:mmt_mobile/route/route_list.dart';
import 'package:mmt_mobile/sync/bloc/sync_action_bloc/sync_action_bloc_cubit.dart';
import 'package:mmt_mobile/ui/account_payment_page.dart';
import 'package:mmt_mobile/ui/customer_dashboard_page.dart';
import 'package:mmt_mobile/ui/customer_visit_report_page.dart';
import 'package:mmt_mobile/ui/dashboard_page.dart';
import 'package:mmt_mobile/ui/login/admin_login.dart';
import 'package:mmt_mobile/ui/login/login_page.dart';
import 'package:mmt_mobile/ui/sale_order_page.dart';
import 'package:mmt_mobile/ui/today_delivery_page.dart';

import '../business logic/bloc/login/login_bloc.dart';
import '../ui/contact_page.dart';
import '../ui/product_report_page.dart';
import '../ui/profile_page.dart';
import '../ui/route_page.dart';
import '../ui/splash_page.dart';

Route<Map<String, dynamic>> generateRoute(RouteSettings routeSettings) {
  debugPrint("Route ::::::::: ${routeSettings.name}");
  switch (routeSettings.name) {
    case RouteList.splash:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [BlocProvider(create: (context) => LoginBloc())],
            child: const SplashScreen(),
          ));
    case RouteList.adminLoginPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LoginBloc()),
              BlocProvider(create: (context) => FetchDatabaseCubit()),
            ],
            child: const AdminLoginPage(),
          ));
    case RouteList.loginPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [BlocProvider(create: (context) => LoginBloc())],
            child: const LoginPage(),
          ));
    case RouteList.homePage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [BlocProvider(create: (context) => SyncActionCubit())],
            child: const DashboardPage(),
          ));
    case RouteList.profilePage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [BlocProvider(create: (context) => SyncActionCubit())],
            child: const ProfilePage(),
          ));
    // case RouteList.dashboardPage:
    //   return _buildPageRoute(routeSettings, const DashboardPage() );
    case RouteList.routePage:
      return _buildPageRoute(routeSettings, const RoutePage());
    case RouteList.contactPage:
      return _buildPageRoute(routeSettings, const ContactPage());
    case RouteList.productReportPage:
      return _buildPageRoute(routeSettings, const ProductReportPage());
    case RouteList.customerVisitPage:
      return _buildPageRoute(routeSettings, const CustomerVisitReportPage());
    case RouteList.todayOrderPage:
      return _buildPageRoute(routeSettings, const SaleOrderPage());
    case RouteList.todayDeliveryPage:
      return _buildPageRoute(routeSettings, const TodayDeliveryPage());
    case RouteList.customerDashboardPage:
      return _buildPageRoute(routeSettings, const CustomerDashboardPage());
    case RouteList.accountPayment:
      return _buildPageRoute(routeSettings, const AccountPaymentPage());
    default:
      return _buildPageRoute(routeSettings, const NotFoundPage());
  }
}

MaterialPageRoute<Map<String, dynamic>> _buildPageRoute(
    RouteSettings routeSettings, Widget page) {
  return MaterialPageRoute<Map<String, dynamic>>(
      builder: (context) => page, settings: routeSettings);
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget("Page not found"),
      ),
    );
  }
}
