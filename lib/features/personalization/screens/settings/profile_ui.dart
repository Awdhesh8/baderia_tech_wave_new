// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatelessWidget {
//   final Map<String, String> userDetails = {
//     'Gn No': 'G/2023/Engg/CS56',
//     'Enrollment Number': '121CS12024',
//     'Father’s Name': 'Jon Wick Jones',
//     'Mother’s Name': 'Jon Wick Jones',
//     'Date of Birth': 'Jan 01 2024',
//     'Contact No': '9898987777',
//     'Course': 'Engg',
//     'Branch': 'CS',
//     'Address': 'Jabalpur, M.P. 482001',
//     'Parent Contact': '7979797777',
//     'Email': 'google@gmail.com',
//     'Category': 'General',
//     'Blood Group': 'A+',
//     'Aadhaar No': '1245 6789 1234 5678',
//     'Samarga Id': '121JBP456',
//     'Laptop': 'YES',
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.redAccent,
//             fontFamily: 'Inter',
//           ),
//         ),
//         backgroundColor: Colors.grey[200],
//         elevation: 0, // No shadow for neomorphic look
//       ),
//       backgroundColor: Colors.grey[200],
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[300]!,
//                     offset: Offset(5, 5),
//                     blurRadius: 10.0,
//                     spreadRadius: -5,
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-5, -5),
//                     blurRadius: 10.0,
//                     spreadRadius: -5,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage(
//                     'assets/avaters/Avatar Default.jpg',
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[300]!,
//                     offset: Offset(5, 5),
//                     blurRadius: 10.0,
//                     spreadRadius: -5,
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-5, -5),
//                     blurRadius: 10.0,
//                     spreadRadius: -5,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: userDetails.entries
//                     .map((entry) => _buildDetailContainer(
//                   entry.key,
//                   entry.value,
//                 ))
//                     .toList(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[300]!,
//                     offset: Offset(5, 5),
//                     blurRadius: 10.0,
//                     spreadRadius: -5,
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-5, -5),
//                     blurRadius: 10.0,
//                     spreadRadius: -5,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Additional Information',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[700],
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailContainer(String key, String value) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey[400]!,
//             offset: Offset(3, 3),
//             blurRadius: 6.0,
//           ),
//           BoxShadow(
//             color: Colors.white,
//             offset: Offset(-3, -3),
//             blurRadius: 6.0,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             key,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//               fontFamily: 'Inter',
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[700],
//               fontFamily: 'Inter',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///


import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, String> userDetails = {
    'Gn No': 'G/2023/Engg/CS56',
    'Enrollment Number': '121CS12024',
    'Father’s Name': 'Jon Wick Jones',
    'Mother’s Name': 'Jon Wick Jones',
    'Date of Birth': 'Jan 01 2024',
    'Contact No': '9898987777',
    'Course': 'Engg',
    'Branch': 'CS',
    'Address': 'Jabalpur, M.P. 482001',
    'Parent Contact': '7979797777',
    'Email': 'google@gmail.com',
    'Category': 'General',
    'Blood Group': 'A+',
    'Aadhaar No': '1245 6789 1234 5678',
    'Samarga Id': '121JBP456',
    'Laptop': 'YES',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0, // No shadow for neomorphic look
      ),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent.withOpacity(0.3),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/avaters/Avatar Default.jpg',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: userDetails.entries
                      .map((entry) => _buildDetailContainer(
                    entry.key,
                    entry.value,
                  ))
                      .toList(),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        offset: Offset(5, 5),
                        blurRadius: 10.0,
                        spreadRadius: -5,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 10.0,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContainer(String key, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            offset: Offset(3, 3),
            blurRadius: 6.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-3, -3),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontFamily: 'Inter',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

