import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';

class KEAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const KEAppbar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () => context.pop(),
      //   icon: const Icon(CupertinoIcons.chevron_back),
      // ),
      leading: const BackButton(),
      title: Text(title ?? ''),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
