import 'package:flutter/widgets.dart';

import '../src/const_dimen.dart';
import '../ui/widgets/responsive.dart';

class GridUtils {
  static SliverGridDelegate createSliverDelicate(BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            (Responsive.currentWidth(context) ~/ ConstantDimens.gridItemWidth)
                .toInt(),
        childAspectRatio: Responsive.isMobile(context)
            ? ConstantDimens.gridItemWidth / ConstantDimens.gridItemWidth
            : ConstantDimens.gridItemWidth / ConstantDimens.gridItemHeight,
        crossAxisSpacing: ConstantDimens.smallPadding,
        mainAxisSpacing: ConstantDimens.smallPadding);
  }

  static SliverGridDelegate createDashboardSliverDelicate(
      BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getDashboardCrossAxisCount(context),
        childAspectRatio: (100 / 140),
        crossAxisSpacing: ConstantDimens.smallPadding,
        mainAxisSpacing: ConstantDimens.smallPadding);
  }

  static int getDashboardCrossAxisCount(BuildContext context){
    return (Responsive.currentWidth(context) ~/
        ConstantDimens.dashboardGridItemWidth)
        .toInt();
  }
}
