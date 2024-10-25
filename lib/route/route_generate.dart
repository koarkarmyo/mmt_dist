import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/route/route_list.dart';
import 'package:mmt_mobile/ui/home_page.dart';

import '../business logic/bloc/login/login_bloc.dart';
import '../ui/splash_page.dart';

Route<Map<String, dynamic>> generateRoute(RouteSettings routeSettings) {
  print("Route ::::::::: ${routeSettings.name}");
  switch (routeSettings.name) {
    case RouteList.splash:
      return _buildPageRoute(routeSettings,  MultiBlocProvider(
        providers: [BlocProvider(create: (context) => LoginBloc())],
        child: const SplashScreen(),
      ));
    case RouteList.homePage:
      return _buildPageRoute(routeSettings, const  HomePage() );
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
    return const SafeArea(
      child: Column(
        children: [
          Text('Not found Page !'),
        ],
      ),
    );
  }
}
