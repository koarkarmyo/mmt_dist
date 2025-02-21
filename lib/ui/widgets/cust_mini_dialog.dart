import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../common_widget/text_widget.dart';
import '../../model/res_partner.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class CustDialog extends SimpleDialog {
  static SimpleDialog createDialog(
      BuildContext context, ResPartner selectedCustomer,
      [VoidCallback? callback]) {
    return SimpleDialog(
      // contentPadding: EdgeInsets.all(ConstantDimens.pagePadding),
      titlePadding: const EdgeInsets.only(right: 8, top: 8, left: 8, bottom: 8),
      title: Row(
        children: [
          Expanded(
              child: Text(
            selectedCustomer.name!,
            textAlign: TextAlign.start,
          )),
          // Expanded(
          //   child:
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // Navigator.pushNamed(context, RouteList.customerCreateRoute,
                  //     arguments: selectedCustomer)
                  //     .then((value) {
                  //   Navigator.pop(context, value);
                  // });
                  context.pushTo(
                      route: RouteList.customerEditPage,
                      args: {'customer': selectedCustomer});
                },
                child: CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryColorPale,
                    child: const Icon(Icons.edit))),
            // ),
          )
        ],
      ).padding(padding: 8.allPadding),
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: MemoryImage(base64Decode(MMTApplication.defaultUserImage)),
              fit: BoxFit.fitHeight, // Ensures the image fits the circle
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () async {
                  // bool isSuccess = await _getMapLocation(
                  //     selectedCustomer.partnerLatitude ?? 0,
                  //     selectedCustomer.partnerLongitude ?? 0);
                  //   if (!isSuccess)
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => LocationDirectionPage(
                  //               startLat:
                  //               selectedCustomer.partnerLatitude ?? 0,
                  //               startLong:
                  //               selectedCustomer.partnerLongitude ?? 0,
                  //             )));
                }),
            IconButton(
                icon: const Icon(Icons.directions),
                onPressed: () async {
                  // bool isSuccess = await _getMapLocation(
                  //     selectedCustomer.partnerLatitude ?? 0,
                  //     selectedCustomer.partnerLongitude ?? 0,
                  //     getDirection: true);
                  // if (!isSuccess)
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => LocationDirectionPage(
                  //             startLat:
                  //             LocationUtils.locationData?.latitude ??
                  //                 0.0,
                  //             startLong:
                  //             LocationUtils.locationData?.longitude ??
                  //                 0.0,
                  //             destLat:
                  //             selectedCustomer.partnerLatitude ?? 0,
                  //             destLong:
                  //             selectedCustomer.partnerLongitude ?? 0,
                  //             getDirection: true,
                  //           )));
                }),
            IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () async {
                  // await _launchCaller(selectedCustomer.phone);
                }),
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 2,
            runSpacing: 2,
            children: [
              const Chip(
                  side: BorderSide(color: Colors.transparent),
                  label: TextWidget(
                    'Total Ordered : 0',
                    dataList: [ConstString.totalOrdered, ': 0'],
                    style: TextStyle(fontSize: 12),
                  ),
                  backgroundColor: AppColors.infoColor),
              Chip(
                  side: const BorderSide(color: Colors.transparent),
                  label: const TextWidget('Total Invoiced : 0',
                      dataList: [ConstString.totalInvoiced, ': 0'],
                      style: TextStyle(fontSize: 12)),
                  backgroundColor: AppColors.successColor),
              Chip(
                  side: const BorderSide(color: Colors.transparent),
                  label: const TextWidget('Total Due : 0',
                      dataList: [ConstString.totalDue, ': 0'],
                      style: TextStyle(fontSize: 12)),
                  backgroundColor: AppColors.dangerColor),
            ],
          ),
        ),
      ],
    );
  }

// static Future<bool> _getMapLocation(double latitude, double longitude,
//     {bool getDirection = false}) async {
//   String partnerLat = latitude.toString();
//   String partnerLong = longitude.toString();
//
//   String mapUrl = 'search/?api=1&query=${partnerLat},${partnerLong}';
//
//   if (getDirection) {
//     mapUrl =
//     'dir/?api=1&destination=$partnerLat,$partnerLong&travelmode=driving&dir_action=navigate';
//   }
//
//   // const String url =
//   //     'https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=21.9036399,96.1233585|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate';
//
//   // final String googleMapslocationUrl = "https://www.google.com/maps/$mapUrl";
//
//   // return await _launchURL(googleMapslocationUrl);
// }

// static Future<bool> _launchURL(String mapUrl) async {
//   final String encodedURl = Uri.encodeFull(mapUrl);
//
//   // if (await canLaunch(encodedURl)) {
//   //   await launch(encodedURl);
//   //   return true;
//   // } else {
//     // print('Could not launch $encodedURl');
//     // throw 'Could not launch $encodedURl';
//     return false;
//   }
// }

// static _launchCaller(String? phone) async {
//   String phoneNo = phone ?? '';
//   String url = 'tel:$phoneNo';
//   // if (await canLaunch(url)) {
//   //   await launch(url);
//   // } else {
//   //   throw 'Could not launch $url';
//   // }
// }
}
