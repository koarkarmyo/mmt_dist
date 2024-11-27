import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';

import '../../model/partner.dart';
import '../../model/res_partner.dart';
import '../../route/route_list.dart';
import '../../src/style/app_color.dart';

class CustDialog extends SimpleDialog {
  static String defaultUserImage =
      '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';

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
                  context.pushTo(route: RouteList.customerEditPage, args: {
                    'customer' : selectedCustomer
                  });
                },
                child: const CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.edit))),
            // ),
          )
        ],
      ),
      children: [
        CircleAvatar(
          radius: 120,
          backgroundImage: MemoryImage(base64Decode(defaultUserImage)),
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
              Chip(
                  side: const BorderSide(color: Colors.transparent),
                  label: const Text(
                    'Total Ordered : 0',
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: AppColors.infoColor),
              Chip(
                  side: const BorderSide(color: Colors.transparent),
                  label: const Text(
                      'Total Invoiced : 0',
                      style:  TextStyle(fontSize: 12)),
                  backgroundColor: AppColors.successColor),
              Chip(
                  side: const BorderSide(color: Colors.transparent),
                  label: const Text(
                      'Total Due : 0',
                      style: const TextStyle(fontSize: 12)),
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
