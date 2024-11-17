import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget shimmerWidget({required double height, required double width, double? radius}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[200]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: radius != null ? BorderRadius.circular(radius) : null,
      ),
      height: height,
      width: width,
    ),
  );
}
