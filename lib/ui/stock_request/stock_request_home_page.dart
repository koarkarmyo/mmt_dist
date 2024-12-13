import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/ui/stock_request/stock_request_list_page.dart';
import 'package:mmt_mobile/ui/stock_request/stock_request_summary.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../model/stock_location.dart';
import '../../route/route_generate.dart';

class StockRequestHomePage extends StatefulWidget {
  const StockRequestHomePage({super.key});

  @override
  State<StockRequestHomePage> createState() => _StockRequestHomePageState();
}

class _StockRequestHomePageState extends State<StockRequestHomePage> {

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [const StockRequestListPage(), const StockRequestSummary()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        // canPop: true, // Indicate that this page can be popped
        // onPopInvokedWithResult: (didPop, result) {
        //   if (_controller.index == 0) {
        //     Future.delayed(const Duration(milliseconds: 50), () {
        //       if (Navigator.of(context).canPop()) {
        //         context.pop(result); // Perform the pop action with a delay
        //       }
        //     });
        //   }
        // },
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardAppears: true,
          handleAndroidBackButtonPress: false,
          // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
          padding: const EdgeInsets.only(top: 8),
          backgroundColor: Colors.grey.shade900,

          isVisible: true,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              duration: Duration(milliseconds: 200),
              screenTransitionAnimationType:
                  ScreenTransitionAnimationType.fadeIn,
            ),
          ),
          confineToSafeArea: true,
          navBarHeight: kBottomNavigationBarHeight,
          navBarStyle:
              NavBarStyle.style6, // Choose the nav bar style with this property
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.list_bullet),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.cart),
          title: ("Summary"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),

    ];
  }
}
