import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/ui/delivery/delivery_foc_item_page.dart';
import 'package:mmt_mobile/ui/delivery/delivery_item_page.dart';
import 'package:mmt_mobile/ui/delivery/delivery_summary_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../route/route_generate.dart';
import '../../src/style/app_color.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);
  bool _isPopping = false; // Flag to prevent double pops
  SaleOrder? _saleOrder;

  List<Widget> _buildScreens() {
    return [
      const DeliveryItemPage(),
      const DeliveryFocItemPage(),
      // const DeliveryCouponPage(),
      DeliverySummaryPage(
        saleOrder: _saleOrder,
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    print("Route data : $data");
    if (data != null) {
      _saleOrder = data['sale_order'];
      print(_saleOrder?.toJsonDB());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      handleAndroidBackButtonPress: false,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      screens: _buildScreens(),
      items: _navBarsItems(),
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: AppColors.primaryColor,
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
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.cart),
          title: ("Delivery Item"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.settings),
          title: ("FOC"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      // PersistentBottomNavBarItem(
      //     icon: const Icon(CupertinoIcons.tag_circle),
      //     title: ("Coupon"),
      //     activeColorPrimary: CupertinoColors.activeBlue,
      //     inactiveColorPrimary: CupertinoColors.systemGrey,
      //     routeAndNavigatorSettings:
      //         const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.sum),
          title: ("Summary"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
    ];
  }
}
