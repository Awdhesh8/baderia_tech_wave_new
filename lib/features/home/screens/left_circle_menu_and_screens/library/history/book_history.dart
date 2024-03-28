import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/animations/common_animation.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../library_screen.dart';
import 'book_history_widget/book_history_contanier.dart';

class BookHistoryScreen extends StatefulWidget {
  const BookHistoryScreen({super.key});

  @override
  State<BookHistoryScreen> createState() => _BookHistoryScreenState();
}

class _BookHistoryScreenState extends State<BookHistoryScreen> {
  List<Map<String, dynamic>> historyBook = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    libraryHistory();
  }

  Future<void> libraryHistory() async {
    try {
      setState(() {
        isLoading = true;
      });

      var result = await ApiService.libraryHistory();

      if (result['status'] == '1') {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(result['response'] ?? []);
        print(responseData);

        setState(() {
          historyBook = responseData;
          isLoading = false;
        });
      } else {
        throw Exception(result['message'] ?? 'Failed to load Data');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Library History',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // SizedBox(
            //   height: ESizes.spaceBtwSections + 44,
            // ),
            /// Title Heading for Books History
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: AnimationWidget(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    animationType: 'fade',
                    child: const TopHeading(
                      text:
                          'A Historical View of\nYour Checked-Out\nCollection',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),

            // Container with Book History Data
            /// Container with Book Data
            isLoading
                ? Center(
                    child: ShimmerLoadingWidget(),
                  )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: historyBook.length,
                    itemBuilder: (context, index) {
                      var book = historyBook[index];
                      final duration = 170 * (index + 1);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimationWidget(
                          duration: Duration(milliseconds: duration),
                          curve: Curves.easeInOut,
                          animationType: 'translate',
                          child: BookHistoryContainer(
                            imageUrl: book['cover_image'] ?? '',
                            title: book['book_title'] ?? 'NA',
                            author: book['author'] ?? '',
                            issueDateTime: book['issued_date'] ?? '',
                            returnDateTime: book['return_date'] ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget ShimmerLoadingWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BookContainerShimmer(),
            );
          },
        ),
      ),
    );
  }
}

/// -->
// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/library/book_data/book_data_class.dart';
// import '../../../../../../common/widgets/appbar/appbar.dart';
// import '../../../../../../common/widgets/texts/top_first_heading.dart';
// import '../../../../../../data/api/api_services.dart';
// import '../../../../../../utils/constants/colors.dart';
// import '../../../../../../utils/constants/sizes.dart';
// import 'book_history_widget/book_history_contanier.dart';
//
// class BookHistoryScreen extends StatefulWidget {
//   const BookHistoryScreen({super.key});
//
//   @override
//   State<BookHistoryScreen> createState() => _BookHistoryScreenState();
// }
//
// class _BookHistoryScreenState extends State<BookHistoryScreen> {
//   List<Map<String, dynamic>> historyBook = [];
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     libraryHistory();
//   }
//
//   Future<void> libraryHistory() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//
//       var result = await ApiService.libraryHistory();
//
//       if (result['status'] == '1') {
//         List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(result['response'] ?? []);
//         print(responseData);
//
//         setState(() {
//           historyBook = responseData;
//           isLoading = false;
//         });
//       } else {
//         throw Exception(result['message'] ?? 'Failed to load Data');
//       }
//     } catch (error) {
//       print('Error: $error');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Library History',
//           style: TextStyle(
//             color: EColors.textColorPrimary1,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//         centerTitle: true,
//         showBackArrow: true,
//       ),
//
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             // SizedBox(
//             //   height: ESizes.spaceBtwSections + 44,
//             // ),
//
//             /// Title Heading for Books History
//             const Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 22),
//                   child: TopHeading(
//                     text: 'A Historical View of\nYour Checked-Out\nCollection',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: ESizes.spaceBtwItems,
//             ),
//
//             // Container with Book History Data
//             /// Container with Book Data
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 children: BookData.books.map((bookData) {
//                   return BookHistoryContainer(bookData: bookData);
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
