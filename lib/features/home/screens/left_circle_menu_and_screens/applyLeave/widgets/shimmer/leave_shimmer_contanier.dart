import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Shimmer effect widget for Leave Application History
class ShimmerLeaveHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5, // You can adjust the count based on how many shimmer placeholders you want
            (index) => ListTile(
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}