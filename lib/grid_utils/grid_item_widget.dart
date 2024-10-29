import 'package:flutter/material.dart';

import '../src/const_dimen.dart';
import '../ui/widgets/memory_asset_image_view.dart';

class GridItemWidget<T> extends StatelessWidget {
  final String title;
  final String? image;
  late String? errorImageAssetPath;
  final String? description;
  late bool isClickListenerEnable;
  late VoidCallback? onClickCallBack;
  late Color? bgColor;
  late bool? showMarkIcon;

  GridItemWidget(
      {Key? key,
      required this.title,
      required this.image,
      this.errorImageAssetPath,
      required this.description,
      this.bgColor,
      this.showMarkIcon,
      this.onClickCallBack})
      : super(key: key) {
    this.isClickListenerEnable = onClickCallBack != null;
    this.errorImageAssetPath;
    this.showMarkIcon ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          if (this.isClickListenerEnable) {
            onClickCallBack?.call();
          }
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18 / 14,
                  child: MemoryAssetImage(
                      memoryImage: image ?? '',
                      assetImagePath: errorImageAssetPath),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(ConstantDimens.smallPadding),
                    child: Text(
                      title,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            if (showMarkIcon!)
              Positioned(
                  top: 1,
                  right: 1,
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ))
          ],
        ),
      ),
    );
  }
}
// _gridTile() {
//   return InkWell(
//     onTap: () {
//       if (this.isClickListenerEnable) {
//         onClickCallBack?.call();
//       }
//     },
//     child: Card(
//       elevation: 10,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: GridTile(
//         header: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               padding: EdgeInsets.all(4),
//               child: Text(
//                 "100",
//                 style: TextStyle(color: Colors.white),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.purpleAccent,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(4),
//               child: Text(
//                 description ?? '',
//                 style: TextStyle(color: Colors.white),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey,
//               ),
//             ),
//           ],
//         ),
//         child: AspectRatio(
//           aspectRatio: 18 / 14,
//           child: Image.asset(image ?? errorImagePerson, fit: BoxFit.fill),
//         ),
//         footer: Container(
//           padding: EdgeInsets.all(8),
//           color: Colors.white.withOpacity(0.7),
//           child: Text(
//             title,
//             maxLines: 1,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// child: Image.asset(image, fit: BoxFit.fill),
// child: Image.memory(
//   base64Decode(image ?? ''),
//   fit: BoxFit.fill,
//   errorBuilder: (context, _, error) {
//     return ColorFiltered(
//       colorFilter: ColorFilter.mode(
//         Colors.grey,
//         BlendMode.saturation,
//       ),
//       child: Image.asset(
//         errorImageAssetPath!,
//         fit: BoxFit.fitHeight,
//       ),
//     );
//   },
// ),

// Positioned(
//   top: 1,
//   child: Container(
//     padding: EdgeInsets.all(4),
//     child: Text(
//       "-1",
//       style: TextStyle(color: Colors.white),
//     ),
//     decoration: BoxDecoration(
//       //TODO : stock > 0 ? Colors.blueGrey: Colors.purpleAccent.shade400
//       color: Colors.purpleAccent.shade400,
//     ),
//   ),
// ),
// Positioned(
//   top: 1,
//   right: 1,
//   child: Container(
//     padding: EdgeInsets.all(4),
//     child: Text(
//       description ?? '',
//       textAlign: TextAlign.right,
//       style: TextStyle(color: Colors.white),
//     ),
//     decoration: BoxDecoration(
//       color: Colors.blueGrey,
//     ),
//   ),
// )
