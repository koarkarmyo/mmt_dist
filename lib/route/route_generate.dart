import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/batch_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/customer/customer_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/dashboard/dashboard_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/fetch_database/fetch_database_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/lot/lot_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/product_category/product_category_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/sale_order/sale_order_cubit.dart';
import 'package:mmt_mobile/common_widget/text_widget.dart';
import 'package:mmt_mobile/route/route_list.dart';
import 'package:mmt_mobile/sync/bloc/sync_action_bloc/sync_action_bloc_cubit.dart';
import 'package:mmt_mobile/ui/account_payment_page.dart';
import 'package:mmt_mobile/ui/customer_dashboard_page.dart';
import 'package:mmt_mobile/ui/customer_visit_report_page.dart';
import 'package:mmt_mobile/ui/dashboard_page.dart';
import 'package:mmt_mobile/ui/delivery/delivery_list_page.dart';
import 'package:mmt_mobile/ui/delivery/delivery_page.dart';
import 'package:mmt_mobile/ui/loading/stock_loading_add_page.dart';
import 'package:mmt_mobile/ui/login/admin_login.dart';
import 'package:mmt_mobile/ui/login/login_page.dart';
import 'package:mmt_mobile/ui/sale_order/sale_order_add_extra.dart';
import 'package:mmt_mobile/ui/sale_order/sale_order_add_product.dart';
import 'package:mmt_mobile/ui/sale_order/sale_order_page.dart';
import 'package:mmt_mobile/ui/today_delivery_page.dart';

import '../business logic/bloc/login/login_bloc.dart';
import '../ui/contact_page.dart';
import '../ui/loading/stock_loading_history_page.dart';
import '../ui/product_report_page.dart';
import '../ui/profile_page.dart';
import '../ui/route_page.dart';
import '../ui/sale_order_history_page.dart';
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
            providers: [
              BlocProvider(create: (context) => SyncActionCubit()),
              BlocProvider(create: (context) => DashboardCubit())
            ],
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
      return _buildPageRoute(routeSettings, const SaleOrderHistoryPage());
    case RouteList.saleOrderAddProductPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [BlocProvider(create: (context) => ProductCubit())],
            child: const SaleOrderAddProductPage(),
          ));
    case RouteList.saleOrderPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ProductCubit()),
              BlocProvider(
                create: (context) => CartCubit(),
              ),
              BlocProvider(
                create: (context) => ProductCategoryCubit(),
              ),
              BlocProvider(
                create: (context) => SaleOrderCubit(),
              )
            ],
            child: const SaleOrderPage(),
          ));

    case RouteList.deliveryPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ProductCubit()),
              BlocProvider(
                create: (context) => CartCubit(),
              ),
              BlocProvider(
                create: (context) => ProductCategoryCubit(),
              ),
              BlocProvider(
                create: (context) => SaleOrderCubit(),
              )
            ],
            child: const DeliveryPage(),
          ));
    // case RouteList.scannerPage:
    //   return _buildPageRoute(routeSettings, const ScannerPage());
    case RouteList.todayDeliveryPage:
      return _buildPageRoute(routeSettings, const TodayDeliveryPage());
    case RouteList.customerDashboardPage:
      return _buildPageRoute(routeSettings, const CustomerDashboardPage());
    case RouteList.accountPayment:
      return _buildPageRoute(routeSettings, const AccountPaymentPage());
    case RouteList.saleOrderAddExtraPage:
      return _buildPageRoute(routeSettings, const SaleOrderAddExtra());
    case RouteList.deliveryListPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [BlocProvider(create: (context) => CustomerCubit())],
            child: const DeliveryListPage(),
          ));
    case RouteList.stockLoadingAddPage:
      return _buildPageRoute(
          routeSettings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => BatchCubit()),
              BlocProvider(create: (context) => ProductCubit()),
              BlocProvider(create: (context) => LotCubit()),
            ],
            child: const StockLoadingAddPage(),
          ));
    case RouteList.loadingHistoryPage:
      return _buildPageRoute(routeSettings, const StockLoadingHistoryPage());

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
