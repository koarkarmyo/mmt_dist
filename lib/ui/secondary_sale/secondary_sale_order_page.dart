import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/promotion/promotion_cubit.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/ui/sale_order/foc_item_page.dart';
import 'package:mmt_mobile/ui/sale_order/sale_order_sale_item_page.dart';
import 'package:mmt_mobile/ui/sale_order/sale_summary_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../model/secondary_sale/secondary_sale_order.dart';
import '../../route/route_generate.dart';
import '../../src/style/app_color.dart';
import 'secondary_sku_product_page.dart';

class SecondarySaleOrderPage extends StatefulWidget {
  const SecondarySaleOrderPage({super.key});

  @override
  State<SecondarySaleOrderPage> createState() => _SecondarySaleOrderPageState();
}

class _SecondarySaleOrderPageState extends State<SecondarySaleOrderPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  ResPartner? _customer;
  SecondarySaleOrder? _so;
  bool _isInit = true;
  late CartCubit _cartCubit;

  @override
  void initState() {
    context.read<PromotionCubit>().fetchPromotions();
    _cartCubit = context.read<CartCubit>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Map<String, dynamic>? data =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (data != null) {
        _customer = data['customer'];
        _so = data['sale_order'];
        _cartCubit.addProductList(list: _so?.orderLines ?? []);
      }
    }
    _isInit = false;
  }

  List<Widget> _buildScreens() {
    return [
      SecondarySKUProductPage(
        customer: _customer,
        saleOrder: _so,
      ),
      const SaleOrderSaleItemPage(),
      const FocItemPage(),
      // const CouponItemPage(),
      SaleSummaryPage(saleOrder: _so)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            bool? isOk = await context.showConfirmDialog(
                confirmQuestion: ConstString.areYouSureToExit,
                context: context);
            if (isOk ?? false) {
              context.rootPop();
            }
          }
          // if (_controller.index == 0) {
          //   Future.delayed(const Duration(milliseconds: 50), () {
          //     // if (Navigator.of(context).canPop()) {
          //     //   context.pop(result); // Perform the pop action with a delay
          //     // }
          //     context.rootPop();
          //   });
          // }
        },
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          onItemSelected: (value) {
            debugPrint('intttt $value');
            if (value == 3) {
              _cartCubit.addAmountDiscount();
            }
          },
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
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.cart),
          title: ("Sale"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.tag),
          title: ("FOC"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(CupertinoIcons.tag_circle),
      //   title: ("Coupon"),
      //   activeColorPrimary: CupertinoColors.activeBlue,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      //     routeAndNavigatorSettings:
      //     const RouteAndNavigatorSettings(onGenerateRoute: generateRoute)
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.sum),
        title: ("Summary"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
