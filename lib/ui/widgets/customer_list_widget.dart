// // import 'package:atom_ui/grid_utils/grild_utils.dart';
// // import 'package:atom_ui/on_clicked_listener.dart';
// // import 'package:atom_ui/widgets/memory_asset_image_view.dart';
// // import 'package:atom_ui/widgets/no_item_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:mscm_odoo/business_logic/bloc/bloc_crud_process_state.dart';
// // import 'package:mscm_odoo/business_logic/bloc/customer/customer_bloc.dart';
// // import 'package:mscm_odoo/business_logic/bloc/customer_ui_change/customer_ui_change_cubit.dart';
// // import 'package:mscm_odoo/business_logic/bloc/route_tab_bar_cubit/route_tabbar_select_cubit.dart';
// // import 'package:mscm_odoo/models/partner.dart';
// // import 'package:mscm_odoo/src/constant_dimens.dart';
// // import 'package:mscm_odoo/src/constant_widgets.dart';
// // import 'package:mscm_odoo/src/image_assets.dart';
// // import 'package:mscm_odoo/src/themes.dart';
// // import 'package:mscm_odoo/ui/pages/route_map_page.dart';
// // import 'package:mscm_odoo/ui/widgets/cust_dialog.dart';
//
// import '../../src/const_dimen.dart';
//
// class CustomerListWidget extends StatelessWidget {
//   final OnClickCallBack<Partner> onClickCallBack;
//   final OnClickCallBack<bool>? callBack;
//   final CustomerViewTypes viewType;
//   late CustomerBloc _customerBloc;
//   late List<Partner> customers = [];
//
//   CustomerListWidget(
//       {Key? key,
//         required this.onClickCallBack,
//         required this.viewType,
//         this.callBack})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     _customerBloc = context.read<CustomerBloc>();
//     // _tabBarSelectCubit = context.read<RouteTabbarSelectCubit>();
//     return Scaffold(
//       body: BlocBuilder<CustomerBloc, CustomerState>(
//         builder: (context, state) {
//           if (state.state == BlocCRUDProcessState.fetching) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (state.state == BlocCRUDProcessState.fetchSuccess) {
//             customers = state.customers;
//           }
//           if (customers.isEmpty)
//             return NoItemWidget(ImageAssets.noDataImage, '');
//           if (viewType == CustomerViewTypes.list) {
//             // if(customers.isEmpty){
//             //   return NoItemWidget()
//             // }
//             return _customerListView(context);
//           } else if (viewType == CustomerViewTypes.grid) {
//             return _customerGridView(context);
//           } else {
//             return RouteMapPage();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _customerListView(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.separated(
//             separatorBuilder: ConstantWidgets.separator,
//             itemCount: customers.length,
//             itemBuilder: (context, index) {
//               Partner customer = customers[index];
//               return Stack(
//                 children: [
//                   // ListTile(
//                   //   contentPadding: EdgeInsets.zero,
//                   //   onTap: () => onClickCallBack.call(customer),
//                   //   leading: InkWell(
//                   //     onTap: () {
//                   //       _customerInfo(
//                   //         context,
//                   //         selectedCustomer: customer,
//                   //         callback: callBack,
//                   //       );
//                   //     },
//                   //     child: SizedBox(
//                   //       width: 75,
//                   //       child: MemoryAssetImage(
//                   //         memoryImage: customer.image512 ?? '',
//                   //         assetImagePath: ImageAssets.userImage,
//                   //       ),
//                   //     ),
//                   //     child: Image.memory(
//                   //       base64Decode(customer.image512 ?? ''),
//                   //       errorBuilder: (context, _, error) {
//                   //         return Image.asset(
//                   //           ImageAssets.userImage,
//                   //           width: 100,
//                   //           fit: BoxFit.cover,
//                   //         );
//                   //       },
//                   //       width: 100,
//                   //       fit: BoxFit.cover,
//                   //     ),
//                   //   ),
//                   //   title: Text(customer.name ?? ''),
//                   //   trailing: Text(customer.phone ?? ''),
//                   //   subtitle: Text(customer.getCustomerAddressInfo()),
//                   // ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(
//                         horizontal: ConstantDimens.normalPadding,
//                         vertical: ConstantDimens.normalPadding / 2),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () => _customerInfo(
//                             context,
//                             selectedCustomer: customer,
//                             callback: callBack,
//                           ),
//                           // child: Image.memory(
//                           //   base64Decode(customer.image512 ?? ''),
//                           //   errorBuilder: (context, _, error) {
//                           //     return Image.asset(
//                           //       ImageAssets.personLogo,
//                           //       width: 100,
//                           //       fit: BoxFit.cover,
//                           //     );
//                           //   },
//                           //   width: 100,
//                           //   fit: BoxFit.cover,
//                           // ),
//                           child: Container(
//                             width: 100,
//                             child: MemoryAssetImage(
//                               memoryImage: customer.image512 ?? '',
//                               assetImagePath: ImageAssets.personLogo,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             focusColor: Colors.transparent,
//                             hoverColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                             splashColor: Colors.transparent,
//                             onTap: () => onClickCallBack.call(customer),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: ConstantDimens.normalPadding),
//                               child: Column(
//                                 children: [
//                                   Text(customer.name ?? '',
//                                       style: TextStyle(fontSize: 16)),
//                                   Text(customer.phone ?? ''),
//                                   Text(customer.getCustomerAddressInfo()),
//                                   if (customer.reasonCode != null)
//                                     Text(
//                                       customer.reasonCode ?? '',
//                                       style: TextStyle(
//                                         color: AppColors.dangerColor,
//                                       ),
//                                     ),
//                                   Text(
//                                     'Last Order : ${customer.lastOrderDate()}',
//                                     style: TextStyle(
//                                         color: AppColors.primaryColor),
//                                   ),
//                                   Text(
//                                     'Last Order Amount : ${customer.lastSaleAmount}',
//                                     style: TextStyle(
//                                         color: AppColors.primaryColor),
//                                   ),
//                                   Text(
//                                     'Amount Due : ${customer.totalDue ?? 0}',
//                                     style:
//                                     TextStyle(color: AppColors.dangerColor),
//                                   ),
//                                 ],
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                     child: Text((customer.number ?? (index + 1)).toString()),
//                     color: Colors.green,
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         ConstantWidgets.SizedBoxHeight,
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Text(
//             'Total Count : ${customers.length}',
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge!
//                 .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//
//   _customerInfo(BuildContext context,
//       {required Partner selectedCustomer,
//         OnClickCallBack<bool>? callback}) async {
//     bool? success = await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return CustDialog.createDialog(context, selectedCustomer);
//         });
//     if (success ?? false) {
//       if (callback != null) callback(success!);
//     }
//   }
//
//   Widget _customerGridView(BuildContext context) {
//     return GridView.builder(
//       padding: EdgeInsets.all(ConstantDimens.normalPadding),
//       itemCount: customers.length,
//       gridDelegate: GridUtils.createSliverDelicate(context),
//       // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //     crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
//       itemBuilder: (BuildContext context, int index) {
//         Partner customer = customers[index];
//         return _customerGridItemWidget(context, customer, onClickCallBack);
//       },
//     );
//   }
//
//   Widget _customerGridItemWidget(BuildContext context, Partner customer,
//       OnClickCallBack<Partner> onClick) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 18 / 13,
//           child: GestureDetector(
//             onTap: () => onClickCallBack.call(customer),
//             child: MemoryAssetImage(
//                 memoryImage: customer.image512 ?? '',
//                 assetImagePath: ImageAssets.userImage),
//           ),
//         ),
//         GestureDetector(
//           onTap: () => _customerInfo(context, selectedCustomer: customer),
//           child: Padding(
//             padding: EdgeInsets.all(ConstantDimens.normalPadding),
//             child: Text(
//               customer.name!,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Container(
// //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
// //   color: Colors.red,
// //   child: Row(
// //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //     children: [
// //       Icon(Icons.gps_fixed),
// //       Icon(Icons.phone),
// //     ],
// //   ),
// // )
