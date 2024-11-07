import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/ui/sale_order/coupon_item_page.dart';
import 'package:mmt_mobile/ui/sale_order/foc_item_page.dart';
import 'package:mmt_mobile/ui/sale_order/sale_order_add_product.dart';
import 'package:mmt_mobile/ui/sale_order/sale_order_sale_item_page.dart';
import 'package:mmt_mobile/ui/sale_order/sale_summary_page.dart';
import 'package:mmt_mobile/ui/sale_order_history_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../route/route_generate.dart';

class SaleOrderPage extends StatefulWidget {
  const SaleOrderPage({super.key});

  @override
  State<SaleOrderPage> createState() => _SaleOrderPageState();
}

class _SaleOrderPageState extends State<SaleOrderPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      const SaleOrderAddProductPage(),
      const SaleOrderSaleItemPage(),
      const FocItemPage(),
      const CouponItemPage(),
      const SaleSummaryPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true, // Indicate that this page can be popped
        onPopInvokedWithResult: (didPop, result) {
          if (_controller.index == 0) {
            Future.delayed(const Duration(milliseconds: 50), () {
              if (Navigator.of(context).canPop()) {
                context.pop(result); // Perform the pop action with a delay
              }
            });
          }
        },
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
          title: ("Sale"),
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
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.tag_circle),
        title: ("Coupon"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
          const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.sum),
        title: ("Summary"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}