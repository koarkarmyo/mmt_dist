import 'package:flutter/material.dart';
import 'package:mmt_mobile/common_widget/text_widget.dart';

import '../src/const_string.dart';

class RetryWidget extends StatelessWidget {
  RetryWidget({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(ConstString.fail, style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),),
          IconButton(onPressed: onRetry, icon: Icon(Icons.refresh))
        ],
      ),
    );
  }
}
