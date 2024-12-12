import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoItemWidget extends StatelessWidget {
  final VoidCallback? onClick;

  const NoItemWidget({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => onClick?.call(),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: const CircleAvatar(
          maxRadius: 100,
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.solidFileZipper, size: 40),
              SizedBox(height: 8),
              Text('Retry'),
            ],
          ),
        ),
      ),
    );
  }
}
