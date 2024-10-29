import 'package:flutter/material.dart';
import 'package:mmt_mobile/ui/widgets/responsive.dart';

import '../../src/const_dimen.dart';

// ignore: must_be_immutable
class NoItemWidget extends StatefulWidget {
  final String assetImagePath;
  final String message;
  late VoidCallback? retryClickListener;
  final bool showRetryBtn;

  NoItemWidget(this.assetImagePath, this.message,
      {this.showRetryBtn = false, this.retryClickListener}) {
    retryClickListener ??= () {};
  }

  @override
  _NoItemWidgetState createState() => _NoItemWidgetState();
}

class _NoItemWidgetState extends State<NoItemWidget> {
  @override
  Widget build(BuildContext context) {
    Widget retryBtn = widget.showRetryBtn
        ? ElevatedButton(
            child: Text('Retry'),
            onPressed: widget.retryClickListener,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
          )
        : Container();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (Responsive.currentHeight(context) > 400)
            Image.asset(
              widget.assetImagePath,
              width: Responsive.isMobile(context)
                  ? 150
                  : Responsive.isTablet(context)
                      ? 200
                      : 250,
            ),
          SizedBox(height: ConstantDimens.padding),
          Text('${widget.message}',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: ConstantDimens.padding),
          retryBtn
        ],
      ),
    );
  }
}
