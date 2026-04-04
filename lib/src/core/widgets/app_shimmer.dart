import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  const AppShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(horizontal:20),
        height: height ?? 16,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
