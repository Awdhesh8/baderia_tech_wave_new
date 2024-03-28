import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/api/api_services.dart';
import '../../utils/constants/colors.dart';

class RankingCircleText extends StatelessWidget {
  final double width;
  final double height;

  const RankingCircleText({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: ApiService.getRankAndAttendanceData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmer(); // You can replace this with a loading indicator
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Text('Error fetching data');
        } else {
          // Access data from the snapshot
          var ranking = snapshot.data!['response'][0]['ranking'];
          return Stack(
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(255, 226, 226, 1),
                  border: Border.all(
                    width: 8,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              Positioned(
                top: 59,
                right: 25,
                child: Text(
                  '$ranking',
                  style: const TextStyle(
                    color: EColors.textPrimaryHeading,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                top: 90,
                right: 25,
                child: Text(
                  'RANKING',
                  style: TextStyle(
                      fontSize: 10,
                      color: EColors.textSecondaryTitle,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        }
      },
    );
  }
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // You can customize these colors
      highlightColor: Colors.grey[100]!,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(255, 226, 226, 1),
              border: Border.all(
                width: 8,
                color: Colors.white,
                style: BorderStyle.solid,
              ),
            ),
          ),
          Positioned(
            top: 45,
            right: 25,
            child: Container(
              width: 50, // Adjust the width to match your shimmer size
              height: 15, // Adjust the height to match your shimmer size
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 90,
            right: 25,
            child: Container(
              width: 50, // Adjust the width to match your shimmer size
              height: 10, // Adjust the height to match your shimmer size
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class AttendanceCircleText extends StatelessWidget {
  final double width;
  final double height;

  const AttendanceCircleText({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: ApiService.getRankAndAttendanceData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmer(); // You can replace this with a loading indicator
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Text('Error fetching data');
        } else {
          // Access data from the snapshot
          var attendance = snapshot.data!['response'][0]['attendance'];
          return Stack(
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(255, 226, 226, 1),
                  border: Border.all(
                    width: 8,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              Positioned(
                top: 59,
                left: 17,
                child: Text(
                  '$attendance',
                  style: const TextStyle(
                    color: EColors.textPrimaryHeading,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                top: 90,
                left: 15,
                child: Text(
                  'ATTENDANCE',
                  style: TextStyle(
                      fontSize: 10,
                      color: EColors.textSecondaryTitle,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        }
      },
    );
  }
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // You can customize these colors
      highlightColor: Colors.grey[100]!,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(255, 226, 226, 1),
              border: Border.all(
                width: 8,
                color: Colors.white,
                style: BorderStyle.solid,
              ),
            ),
          ),
          Positioned(
            top: 45,
            right: 25,
            child: Container(
              width: 50, // Adjust the width to match your shimmer size
              height: 15, // Adjust the height to match your shimmer size
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 90,
            right: 25,
            child: Container(
              width: 50, // Adjust the width to match your shimmer size
              height: 10, // Adjust the height to match your shimmer size
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


/// ORIGINAL CODE
// import 'package:flutter/material.dart';
// import '../../utils/constants/colors.dart';
//
// class RankingCircleText extends StatelessWidget {
//   final width;
//   final height;
//
//   const RankingCircleText({
//     Key? key,
//     required this.width,
//     required this.height,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: const Color.fromRGBO(255, 226, 226, 1),
//             border: Border.all(
//               width: 8,
//               color: Colors.white,
//               style: BorderStyle.solid,
//             ),
//           ),
//         ),
//
//         // const Positioned(
//         //   top: 60,
//         //   left: 10,
//         //   child: Text('82%',style: TextStyle(color: Color(0xFFFE1535),fontSize: 40,fontWeight: FontWeight.bold),),
//         // ),
//         // const Positioned(
//         //   top: 110,
//         //   left: 15,
//         //   child: Text('ATTENDANCE',style: TextStyle(fontSize: 10),),
//         // ),
//
//         const Positioned(
//           top: 45,
//           right: 25,
//           child: Text(
//             '14',
//             style: TextStyle(
//                 color: EColors.textPrimaryHeading,
//                 fontSize: 37,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Positioned(
//           top: 90,
//           right: 25,
//           child: Text(
//             'RANKING',
//             style: TextStyle(
//                 fontSize: 10,
//                 color: EColors.textSecondaryTitle,
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AttendanceCircleText extends StatelessWidget {
//   final width;
//   final height;
//
//   const AttendanceCircleText({
//     Key? key,
//     required this.width,
//     required this.height,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: const Color.fromRGBO(255, 226, 226, 1),
//             border: Border.all(
//               width: 8,
//               color: Colors.white,
//               style: BorderStyle.solid,
//             ),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: const Color(0x1C000000).withOpacity(0.11),
//             //     blurRadius: 3.90,
//             //     offset: const Offset(0, 0),
//             //     spreadRadius: 0,
//             //   ),
//             // ],
//           ),
//         ),
//         const Positioned(
//           top: 45,
//           left: 21,
//           child: Text(
//             '82%',
//             style: TextStyle(
//                 color: EColors.textPrimaryHeading,
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Positioned(
//           top: 90,
//           left: 15,
//           child: Text(
//             'ATTENDANCE',
//             style: TextStyle(
//                 fontSize: 10,
//                 color: EColors.textSecondaryTitle,
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//         // const Positioned(
//         //   top: 35,
//         //   right: 25,
//         //   child: Text('14',style: TextStyle(color: Color(0xFFFE1535),fontSize: 40,fontWeight: FontWeight.bold),),
//         // ),
//         // const Positioned(
//         //   top: 80,
//         //   right: 25,
//         //   child: Text('RANKING',style: TextStyle(fontSize: 10),),
//         // ),
//       ],
//     );
//   }
// }
