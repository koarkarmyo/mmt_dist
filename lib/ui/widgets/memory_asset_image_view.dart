import 'dart:convert';

import 'package:flutter/material.dart';

class MemoryAssetImage extends StatelessWidget {
  final String memoryImage;
  late String? assetImagePath;

  MemoryAssetImage({Key? key, required this.memoryImage, this.assetImagePath})
      : super(key: key) {
    assetImagePath ??= 'assets/images/logo_black_white.png';
  }

  @override
  Widget build(BuildContext context) {
    return memoryImage.length > 6 && memoryImage.trim().isNotEmpty
        ? Image.memory(
            base64Decode(memoryImage),
            gaplessPlayback: true,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(assetImagePath!);
            },
          )
        : Image.asset(assetImagePath!, fit: BoxFit.fitHeight);
  }
}
