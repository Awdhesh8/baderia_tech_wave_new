import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../../utils/constants/colors.dart';

/*
class UserDetails extends StatelessWidget {
  final Map<String, dynamic> data;

  const UserDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 380,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0E5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFFFC1C5),
                offset: Offset(-2, -2),
                blurRadius: 5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(5, 5),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          margin: const EdgeInsets.all(8),
          child: data.isNotEmpty
              ? Scrollbar(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: data.entries.map((entry) {
                return ESettingsMenuTile(
                  title: entry.key,
                  subTitle: entry.value.toString(),
                  onTap: () {
                    // Add any onTap functionality here if needed
                  },
                  icon: Iconsax.document_text_14,
                );
              }).toList(),
            ),
          )
              : Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // Adjust the number of shimmer lines as needed
              itemBuilder: (_, __) => ListTileShimmer(),
            ),
          ),
        ),
      ),
    );
  }
}
 */

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> dataList;

  const UserDetails({Key? key, required this.data, required this.dataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.48;

    // Filter out entries with keys "student_name" and "Profile_photo"
    List<MapEntry<String, dynamic>> filteredEntries = data.entries
        .where((entry) =>
            entry.key != "student_name" && entry.key != "Profile_photo")
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Container(
        // height: containerHeight,
        decoration: BoxDecoration(
          // color: EColors.lightContainer1,
          borderRadius: BorderRadius.circular(14),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.white,
          //     // color: Color(0xFFFFC1C5),
          //     offset: Offset(-.5, -.5),
          //     blurRadius: 1,
          //     spreadRadius: 0,
          //   ),
          //   BoxShadow(
          //     color: Color(0xFFFFC1C5),
          //     offset: Offset(5, 5),
          //     blurRadius: 1,
          //     spreadRadius: 0,
          //   ),
          // ],
        ),
        margin: const EdgeInsets.all(8),
        child: dataList.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Scrollbar(
                  child: ListView(
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    physics: NeverScrollableScrollPhysics(),
                    children: filteredEntries.map((entry) {
                      return ESettingsMenuTile(
                        title: entry.key,
                        subTitle: entry.value.toString(),
                        onTap: () {
                          // Add any onTap functionality here if needed
                        },
                        icon: Iconsax.document_text_14,
                      );
                    }).toList(),
                  ),
                ),
            )
            : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (_, __) => ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    ),
                    title: SizedBox(
                      height: 20,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    subtitle: SizedBox(
                      height: 15,
                      width: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class ShimmerProfileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), // Add some spacing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[300],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
class UserDetails extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const UserDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 380,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0E5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFFFC1C5),
                offset: Offset(-2, -2),
                blurRadius: 5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(5, 5),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          margin: const EdgeInsets.all(8),
          child: data.isNotEmpty
              ? Scrollbar(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: data[0].entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key),
                        subtitle: Text(entry.value.toString()),
                      );
                    }).toList(),
                  ),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (_, __) => ListTile(
                      title: SizedBox(
                        height: 20,
                        width: 100,
                        child: Container(color: Colors.grey),
                      ),
                      subtitle: SizedBox(
                        height: 15,
                        width: 50,
                        child: Container(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}


 */

// class UserDetails extends StatelessWidget {
//   final List<dynamic> data;
//
//   const UserDetails({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//         child: Container(
//           height: 380,
//           decoration: BoxDecoration(
//             color: const Color(0xFFFFE0E5),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0xFFFFC1C5),
//                 offset: Offset(-2, -2),
//                 blurRadius: 5,
//                 spreadRadius: 1,
//               ),
//               BoxShadow(
//                 color: Colors.white,
//                 offset: Offset(5, 5),
//                 blurRadius: 5,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           margin: const EdgeInsets.all(8),
//           child: data.isNotEmpty
//               ? Scrollbar(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const BouncingScrollPhysics(),
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 final item = data[index];
//                 if (item is List<dynamic>) {
//                   // Handle the case when item is a list
//                   return Column(
//                     children: item.map((nestedItem) {
//                       if (nestedItem is Map<String, dynamic>) {
//                         return ListTile(
//                           title: Text(nestedItem['type'] ?? ''),
//                           subtitle: Text(nestedItem['value']?.toString() ?? ''),
//                           onTap: () {
//                             // Add any onTap functionality here if needed
//                           },
//                           leading: Icon(Iconsax.document_text_14),
//                         );
//                       } else {
//                         return SizedBox.shrink(); // Handle other cases or provide a fallback
//                       }
//                     }).toList(),
//                   );
//                 } else if (item is Map<String, dynamic>) {
//                   // Handle the case when item is a map
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: Card(
//                       elevation: 2,
//                       child: ListTile(
//                         title: Text(item['type'] ?? ''),
//                         subtitle: Text(item['value']?.toString() ?? ''),
//                         onTap: () {
//                           // Add any onTap functionality here if needed
//                         },
//                         leading: Icon(Iconsax.document_text_14),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return SizedBox.shrink(); // Handle other cases or provide a fallback
//                 }
//               },
//             ),
//           )
//               : Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: 5,
//               itemBuilder: (_, __) => ListTile(
//                 title: SizedBox.shrink(),
//                 subtitle: SizedBox.shrink(),
//                 leading: Icon(Iconsax.document_text_14),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../common/widgets/list_tile/settings_menu_tile.dart';
// import '../../../../../utils/constants/colors.dart';
//
// Map<String, String> personalDetails = {
//   'Gn No': 'G/2023/Engg/CS56',
//   'Enrollment Number': '121CS12024',
//   'Father’s Name': 'Jon Wick Jones',
//   'Mother’s Name': 'Jon Wick Jones',
//   'Date of Birth': 'Jan 01 2024',
//   'Contact No': '9898987777',
//   'Course': 'Engg',
//   'Branch': 'CS',
//   'Address': 'Jabalpur, M.P. 482001',
//   'Parent Contact': '7979797777',
//   'Email': 'google@gmail.com',
//   'Category': 'General',
//   'Blood Group': 'A+',
//   'Aadhaar No': '1245 6789 1234 5678',
//   'Samarga Id': '121JBP456',
//   'Laptop': 'YES',
// };
//
// class UserDetails extends StatelessWidget {
//   final Map<String, String> data;
//
//   const UserDetails({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
//         child: Container(
//           height: 380,
//           decoration: BoxDecoration(
//             color: const Color(0xFFFFE0E5),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0xFFFFC1C5),
//                 offset: Offset(-2, -2),
//                 blurRadius: 5,
//                 spreadRadius: 1,
//               ),
//               BoxShadow(
//                 color: Colors.white,
//                 offset: Offset(5, 5),
//                 blurRadius: 5,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           margin: const EdgeInsets.all(8),
//           child: Scrollbar(
//             child: ListView(
//               shrinkWrap: true,
//               physics: const BouncingScrollPhysics(),
//               children: data.entries.map((entry) {
//                 return ESettingsMenuTile(
//                   title: entry.key,
//                   subTitle: entry.value,
//                   onTap: () {
//                     // Add any onTap functionality here if needed
//                   },
//                   icon: Iconsax.document_text_14,
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
