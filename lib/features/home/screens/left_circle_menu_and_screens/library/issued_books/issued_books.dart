import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../common/widgets/animations/common_animation.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../library_screen.dart';
import 'issue_book_widget/issue_book_contanier.dart';

class IssuedBooksScreen extends StatefulWidget {
  IssuedBooksScreen({super.key});

  @override
  State<IssuedBooksScreen> createState() => _IssuedBooksScreenState();
}

class _IssuedBooksScreenState extends State<IssuedBooksScreen> {
  List<Map<String, dynamic>> issuedBook = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    issuedBooks();
  }

  Future<void> issuedBooks() async {
    try {
      setState(() {
        isLoading = true;
      });

      var result = await ApiService.issuedBooks();

      if (result['status'] == '1') {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(result['response'] ?? []);
        print(responseData);

        setState(() {
          issuedBook = responseData;
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
          'Borrowed Books',
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: AnimationWidget(
                    animationType: 'fade',
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: const TopHeading(
                      text: 'Your Borrowed\nTitles',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            isLoading
                ? Center(
                    child: ShimmerLoadingWidget(),
                  )
                : AnimationWidget(
                    animationType: 'translate',
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubicEmphasized,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: issuedBook.length,
                        itemBuilder: (context, index) {
                          var book = issuedBook[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IssuedBookDetailsContainer(
                              imageUrl: book['cover_image'] ?? '',
                              title: book['book_title'] ?? 'NA',
                              author: book['author'] ?? '',
                              issueDateTime: book['issued_date'] ?? '',
                            ),
                          );
                        },
                      ),
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

// import 'package:flutter/material.dart';
// import '../../../../../../common/widgets/appbar/appbar.dart';
// import '../../../../../../common/widgets/texts/top_first_heading.dart';
// import '../../../../../../utils/constants/colors.dart';
// import '../../../../../../utils/constants/sizes.dart';
// import '../book_data/book_data_class.dart';
// import 'issue_book_widget/issue_book_contanier.dart';
//
// class IssuedBooksScreen extends StatelessWidget {
//   const IssuedBooksScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Borrowed Books',
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
//             /// Title Heading for Issued Books
//             const Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 22),
//                   child: TopHeading(
//                     text: 'Your Borrowed\nTitles',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: ESizes.spaceBtwItems,
//             ),
//
//             // Container with Issued Book Data
//             /// Container with Issued Book Data
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 children: BookData.books.map((bookData) {
//                   return IssuedBookDetailsContainer(bookData: bookData);
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
