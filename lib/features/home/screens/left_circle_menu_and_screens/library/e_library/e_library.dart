import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../common/widgets/animations/common_animation.dart';
import '../../../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../library_screen.dart';
import 'e_book_contanier/e_book_contanier.dart';

class ELibraryScreen extends StatefulWidget {
  const ELibraryScreen({super.key});

  @override
  State<ELibraryScreen> createState() => _ELibraryScreenState();
}

class _ELibraryScreenState extends State<ELibraryScreen> {
  List<Map<String, dynamic>> eBooks = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Call the bookSearch function when the screen initializes
    getEBooks('');
  }

  Future<void> getEBooks(String searchKeyword) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Map<String, dynamic>> result =
          await ApiService.getEBooks(searchKeyword);
      print(result);

      setState(() {
        eBooks = result;
        isLoading = false;
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Book data

    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'eLibrary',
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
            const SizedBox(
              height: ESizes.spaceBtwSections + 44,
            ),

            /// Title Heading for Books
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: AnimationWidget(
                    animationType: 'fade',
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    child: const TopHeading(
                      text: 'Digital Bookshelf:\nBrowse & Enjoy',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),

            // Container with e-Book Data
            /// Container with e-Book Data
            isLoading
                ? Center(
                    child: ShimmerLoadingWidget(),
                  )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true, // Set shrinkWrap to true
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling
                    itemCount: eBooks.length,
                    itemBuilder: (context, index) {
                      var book = eBooks[index];
                      final duration = 170 * (index + 1);
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AnimationWidget(
                          duration:  Duration(milliseconds: duration),
                          curve: Curves.easeInOutCubicEmphasized,
                          animationType: 'translate',
                          child: EBookDetailsContainer(
                            imageUrl: book['cover_image'] ?? '',
                            title: book['book_title'] ?? 'NA',
                            author: book['aublisher'] ?? '',
                            downloadEBook: book['ebook'] ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                ),
            const SizedBox(
              height: ESizes.spaceBtwItems1,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 66),
        child: AnimationWidget(
          animationType: 'fade',
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 600),
          child: CustomSearchContainer(
            showBackground: true,
            dark: false,
            showBorder: true,
            onChanged: (value) {
              // Call bookSearch function whenever the search text changes
              getEBooks(value);
            },
            controller: searchController,
          ),
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
          itemCount: 5, // Adjust the number of shimmer items as needed
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  BookContainerShimmer(), // Create a BookContainerShimmer widget for shimmer effect
            );
          },
        ),
      ),
    );
  }
}

final List<String> defaultEBookImages = [
  'assets/books/1book.jpg',
  'assets/books/2book.jpg',
  'assets/books/3book.jpg',
  'assets/books/4book.jpg',
  'assets/books/1book.jpg',
  'assets/books/2book.jpg',
  'assets/books/3book.jpg',
  'assets/books/4book.jpg',
  // Add more image URLs as needed
];

/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../common/widgets/book_contanier/book_contanier.dart';
import '../../../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../book_data/book_data_class.dart';
import '../library_screen.dart';
import 'book_widget/e_book_widget.dart';
import 'e_book_contanier/e_book_contanier.dart';

class ELibraryScreen extends StatefulWidget {
  const ELibraryScreen({super.key});

  @override
  State<ELibraryScreen> createState() => _ELibraryScreenState();
}

class _ELibraryScreenState extends State<ELibraryScreen> {
  List<Map<String, dynamic>> books = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Call the bookSearch function when the screen initializes
    getEBooks('');
  }

  Future<void> getEBooks(String searchKeyword) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Map<String, dynamic>> result =
      await ApiService.bookSearch(searchKeyword);
      print(result);

      setState(() {
        books = result;
        isLoading = false;
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Book data

    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'eLibrary',
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
            const SizedBox(
              height: ESizes.spaceBtwSections + 44,
            ),

            /// Title Heading for Books
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: TopHeading(
                    text: 'Digital Bookshelf:\nBrowse & Enjoy',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),

            // Container with e-Book Data
            /// Container with e-Book Data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: BookData.books.map((bookData) {
                  return EBookDetailsContainer(bookData: bookData);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(top: 66),
        child: CustomSearchContainer(
          showBackground: true,
          dark: false,
          showBorder: true,
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
          itemCount: 5, // Adjust the number of shimmer items as needed
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              BookContainerShimmer(), // Create a BookContainerShimmer widget for shimmer effect
            );
          },
        ),
      ),
    );
  }
}

final List<String> defaultEBookImages = [
  'assets/books/1book.jpg',
  'assets/books/2book.jpg',
  'assets/books/3book.jpg',
  'assets/books/4book.jpg',
  'assets/books/1book.jpg',
  'assets/books/2book.jpg',
  'assets/books/3book.jpg',
  'assets/books/4book.jpg',
  // Add more image URLs as needed
];

 */
