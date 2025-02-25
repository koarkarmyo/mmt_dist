import 'package:flutter/material.dart';

class KEAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;

  const KEAppbar({
    super.key,
    this.title,
    this.actions,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () => context.pop(),
      //   icon: const Icon(CupertinoIcons.chevron_back),
      // ),
      leading: const BackButton(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '', style: Theme.of(context).textTheme.titleMedium),
          if (subtitle != null)
            Text(
              subtitle ?? '',
              style: const TextStyle(fontSize: 15),
            ),
        ],
      ),
      actions: actions,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
