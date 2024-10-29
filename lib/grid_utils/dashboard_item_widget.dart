import 'dart:convert';
import 'package:flutter/material.dart';

class GridDashboardItem extends StatelessWidget {
  final String title;
  final String image;
  late bool isClickListenerEnable;
  late VoidCallback? onClickCallBack;
  final Color bgColor;

  GridDashboardItem(
      {Key? key,
      required this.title,
      required this.image,
      this.bgColor = Colors.red,
      this.onClickCallBack})
      : super(key: key) {
    isClickListenerEnable = onClickCallBack != null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        if (isClickListenerEnable) {
          onClickCallBack?.call();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                // color: Color(0xfff7a71c),
                color: bgColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(4.0),
              width: 40,
              height: 40,
              clipBehavior: Clip.hardEdge,
              child: image.length > 10
                  ? Image.memory(base64Decode(image))
                  : Icon(
                      Icons.business_center_rounded,
                      color: Colors.white,
                    )),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// child: Card(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Expanded(
//             child: Align(
//           alignment: Alignment.topLeft,
//           child: Text(title,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
//               maxLines: 2,
//               textAlign: TextAlign.left),
//         )),
//         const SizedBox(height: ConstantDimens.smallPadding),
//         Align(
//           alignment: Alignment.centerRight,
//           child: SizedBox(
//             width: 48,
//             height: 48,
//             child: MemoryAssetImage(
//               memoryImage: image,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
