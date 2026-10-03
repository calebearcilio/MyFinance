import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingComponent({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
