import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/animations/common_animation.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_container_button/custom_container_button.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'book_contaner/book_contanier.dart';
import 'e_library/e_library.dart';
import 'history/book_history.dart';
import 'issued_books/issued_books.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Map<String, dynamic>> books = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Call the bookSearch function when the screen initializes
    bookSearch('');
  }

  Future<void> bookSearch(String searchKeyword) async {
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

  Future<void> updateLockStatus(String bookId, bool newLockStatus, BuildContext context) async {
    try {
      await ApiService().updateLockStatus(bookId, newLockStatus, context);

      setState(() {
        // Update the UI as per your requirements
      });
    } catch (error) {
      print('Error updating lock status: $error');
    }
  }
/*
  Future<void> updateLockStatus(String bookId, bool newLockStatus, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    try {
      var headers = {'Cookie': 'ci_session=41u6ft1qdlm59a6h30cuc0or6p46ot2m'};
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(APIConstants.getFullUrl(APIConstants.lockOrUnlockBooks))
        // Uri.parse('http://myglobalapp.in/global/API005/lock_book'),
      );

      // Set request fields
      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'book_id': bookId,
        'lock_status': newLockStatus.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());
        // Print the response data
        print('Response Data: $responseData');

        // Handle the response data as needed
        var status = responseData['status'];
        var message = responseData['message'];

        if (status == '1') {
          // Update was successful, handle accordingly
          print('Lock Status Updated Successfully');

          // Show a SnackBar with the success message
          Get.snackbar('Lock Status : ', '$message',colorText: EColors.textColorPrimary1,);
           // Get.snackbar('Lock Status : $message', 'You can now take the book from the college library.');

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Lock Status Updated Successfully. You can now take the book from the college library.'),
          //     duration: Duration(seconds: 4),
          //   ),
          // );
        } else {
          // Update failed, handle accordingly
          print('Lock Status Update Failed: $message');

          // Show a SnackBar with the failure message
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Lock Status Update Failed: $message'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
          Get.snackbar('Lock Status Update Failed: ', '$message');
        }
      } else {
        // Print the reason phrase in case of non-200 status code
        print('Error: ${response.reasonPhrase}');

        // Show a SnackBar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.reasonPhrase}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Handle any other errors that might occur during the request
      print('Error updating lock status: $error');

      // Show a SnackBar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating lock status: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(210.0),
        child: AnimationWidget(
          animationType: 'fade',
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: GAppBar(
            showBackArrow: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            // centerTitle: true,
            title: const Text(
              'Library',
              style: TextStyle(
                color: EColors.textColorPrimary1,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSearchContainer(
                  showBackground: true,
                  dark: false,
                  showBorder: true,
                  onChanged: (value) {
                    // Call bookSearch function whenever the search text changes
                    bookSearch(value);
                  },
                  controller: searchController,
                ),
                const SizedBox(
                  height: ESizes.spaceBtwItems,
                ),

                /// Three Buttons eLibrary | Issued Book | History
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainerButton(
                        buttonText: 'eLibrary',
                        onTap: () {
                          Get.to(() => const ELibraryScreen(),
                              curve: Curves.easeInOut,
                              transition: Transition.cupertino);
                        },
                      ),
                      CustomContainerButton(
                        buttonText: 'Issued Books',
                        onTap: () {
                          Get.to(() => IssuedBooksScreen(),
                              curve: Curves.easeInOut,
                              transition: Transition.cupertino);
                        },
                      ),
                      CustomContainerButton(
                        buttonText: 'History',
                        onTap: () {
                          Get.to(() => const BookHistoryScreen(),
                              curve: Curves.easeInOut,
                              transition: Transition.cupertino);
                        },
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                const SizedBox(
                  height: ESizes.spaceBtwItems1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // controller: Get.find<ScrollController>(),
        // controller: _scrollController,
        child: Column(
          children: [
            /// Title Heading for Books
            const Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: TopHeading(
                      text:
                          'Unveiling Our Newest\nArrivals: Dive into\nFresh Reads',
                    ),
                ),
              ],
            ),
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
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        var book = books[index];
                        final duration = 170 * (index + 1);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimationWidget(
                            animationType: 'translate',
                            duration: Duration(milliseconds: duration),
                            // duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubicEmphasized,
                            child: BookContainer(
                              imageUrl: book['covor_image'],
                              title: book['book_title'],
                              author: book['author'],
                              availableQty: book['available_qty'],
                              lockStatus: book['lock_status'],
                              bookId: book['title_id'],
                              onTapLockButton: (bool newLockStatus) async {
                                // Handle lock or unlock the book Button
                                // Call the updateLockStatus function using an instance of ApiService
                                var apiService = ApiService();
                                await apiService.updateLockStatus(book['title_id'], newLockStatus, context);

                                // After updating the lock status, refresh the UI if needed
                                setState(() {
                                  book['lock_status'] = newLockStatus ? 'True' : 'False';
                                });
                              },
                              // onTapLockButton: (bool newLockStatus) async {
                              //   // Handle lock or unlock the book Button
                              //   // Call the updateLockStatus function
                              //   await updateLockStatus(book['title_id'], newLockStatus, context);
                              //
                              //   // After updating the lock status, refresh the UI if needed
                              //   setState(() {
                              //     book['lock_status'] = newLockStatus ? 'True' : 'False';
                              //   });
                              // },
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

/// Shimmer
class BookContainerShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:baderia_tech_wave/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/layouts/grid_layout.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_container_button/custom_container_button.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'book_contaner/book_contanier.dart';
import 'book_contaner/book_contanier_new.dart';
import 'e_library/e_library.dart';
import 'history/book_history.dart';
import 'issued_books/issued_books.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Map<String, dynamic>> books = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Call the bookSearch function when the screen initializes
    bookSearch('');

    _scrollController.addListener(() {
      // Check if the user has scrolled down to show the FloatingActionButton
      if (_scrollController.offset >= 300) {
        // Assuming you want to show the button when scrolled down 300 pixels
        setState(() {
          _showScrollToTopButton = true;
        });
      } else {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> bookSearch(String searchKeyword) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Map<String, dynamic>> result =
          await ApiService.bookSearch(searchKeyword);

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
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(210.0),
        child: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Library',
            style: TextStyle(
              color: EColors.textColorPrimary1,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomSearchContainer(
                showBackground: true,
                dark: false,
                showBorder: true,
                onChanged: (value) {
                  // Call bookSearch function whenever the search text changes
                  bookSearch(value);
                },
                controller: searchController,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),

              /// Three Buttons eLibrary | Issued Book | History
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainerButton(
                      buttonText: 'eLibrary',
                      onTap: () {
                        Get.to(() => const ELibraryScreen(),
                            curve: Curves.easeInOut,
                            transition: Transition.cupertino);
                      },
                    ),
                    CustomContainerButton(
                      buttonText: 'Issued Books',
                      onTap: () {
                        Get.to(() => const IssuedBooksScreen(),
                            curve: Curves.easeInOut,
                            transition: Transition.cupertino);
                      },
                    ),
                    CustomContainerButton(
                      buttonText: 'History',
                      onTap: () {
                        Get.to(() => const BookHistoryScreen(),
                            curve: Curves.easeInOut,
                            transition: Transition.cupertino);
                      },
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems1,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            /// Title Heading for Books
            const Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: TopHeading(
                      text:
                      'Unveiling Our Newest\nArrivals: Dive into\nFresh Reads',
                    )),
              ],
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true, // Set shrinkWrap to true
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable scrolling
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        var book = books[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BookContainer(
                            imageUrl: book['covor_image'],
                            title: book['book_title'],
                            author: book['author'],
                            availableQty: book['available_qty'],
                            lockStatus: book['lock_status'],
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
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _scrollToTop,
              tooltip: 'Scroll to Top',
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: const Icon(Iconsax.arrow_up_15),
              ),
            )
          : null,
    );
  }
}
*/

///
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:baderia_tech_wave/common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../common/layouts/grid_layout.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_container_button/custom_container_button.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'book_contaner/book_contanier.dart';
import 'book_contaner/book_contanier_new.dart';
import 'e_library/e_library.dart';
import 'history/book_history.dart';
import 'issued_books/issued_books.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Map<String, dynamic>> books = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Call the bookSearch function when the screen initializes
    bookSearch('');

    _scrollController.addListener(() {
      // Check if the user has scrolled down to show the FloatingActionButton
      if (_scrollController.offset >= 300) {
        // Assuming you want to show the button when scrolled down 300 pixels
        setState(() {
          _showScrollToTopButton = true;
        });
      } else {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> bookSearch(String searchKeyword) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Map<String, dynamic>> result =
          await ApiService.bookSearch(searchKeyword);

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
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(320.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Library',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomSearchContainer(
                showBackground: true,
                dark: false,
                showBorder: true,
                onChanged: (value) {
                  // Call bookSearch function whenever the search text changes
                  bookSearch(value);
                },
                controller: searchController,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),

              /// Three Buttons eLibrary | Issued Book | History
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainerButton(
                      buttonText: 'eLibrary',
                      onTap: () {
                        Get.to(() => const ELibraryScreen(),
                            curve: Curves.easeInOut,
                            transition: Transition.cupertino);
                      },
                    ),
                    CustomContainerButton(
                      buttonText: 'Issued Books',
                      onTap: () {
                        Get.to(() => const IssuedBooksScreen(),
                            curve: Curves.easeInOut,
                            transition: Transition.cupertino);
                      },
                    ),
                    CustomContainerButton(
                      buttonText: 'History',
                      onTap: () {
                        Get.to(() => const BookHistoryScreen(),
                            curve: Curves.easeInOut,
                            transition: Transition.cupertino);
                      },
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems1,
              ),
              /// Title Heading for Books
              const Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: TopHeading(
                        text:
                        'Unveiling Our Newest\nArrivals: Dive into\nFresh Reads',
                      )),
                ],
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
            ],
          ),
        ),
      ),
          /*
      const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: true,
        title: Text(
          'Library',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),

      ),
      */

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            /*
            CustomSearchContainer(
              showBackground: true,
              dark: false,
              showBorder: true,
              onChanged: (value) {
                // Call bookSearch function whenever the search text changes
                bookSearch(value);
              },
              controller: searchController,
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),

            /// Three Buttons eLibrary | Issued Book | History
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainerButton(
                    buttonText: 'eLibrary',
                    onTap: () {
                      Get.to(() => const ELibraryScreen(),
                          curve: Curves.easeInOut,
                          transition: Transition.cupertino);
                    },
                  ),
                  CustomContainerButton(
                    buttonText: 'Issued Books',
                    onTap: () {
                      Get.to(() => const IssuedBooksScreen(),
                          curve: Curves.easeInOut,
                          transition: Transition.cupertino);
                    },
                  ),
                  CustomContainerButton(
                    buttonText: 'History',
                    onTap: () {
                      Get.to(() => const BookHistoryScreen(),
                          curve: Curves.easeInOut,
                          transition: Transition.cupertino);
                    },
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),

            const SizedBox(
              height: ESizes.spaceBtwItems1,
            ),
            /// Title Heading for Books
                  const Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: TopHeading(
                            text:
                                'Unveiling Our Newest\nArrivals: Dive into\nFresh Reads',
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtwItems,
                  ),
            */
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: SizedBox(
                      height: 380,
                      child: ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          var book = books[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookContainer(
                              imageUrl: book['covor_image'],
                              title: book['book_title'],
                              author: book['author'],
                              availableQty: book['available_qty'],
                              lockStatus: book['lock_status'],
                            ),
                          );
  // : Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: EGridLayout(
  //             itemCount: books.length,
  //             mainAxisExtent: 268,
  //             itemBuilder: (context, index) {
  //               var book = books[index];
  //               return BookContainer(
  //                 imageUrl: book['covor_image'],
  //                 title: book['book_title'],
  //                 author: book['author'],
  //                 availableQty: book['available_qty'],
  //                 lockStatus: book['lock_status'],
  //               );


               //  var book = books[index];
               // return ReadingListCard(
               //      imageUrl: book['covor_image'],
               //      title: book['book_title'],
               //      author: book['author'],
               //      availableQty: book['available_qty'],
               //      lockStatus: book['lock_status'],
               //  );


                      // var book = books[index];
                      // return BookContainer(
                      //   imageUrl: book['covor_image'],
                      //   title: book['book_title'],
                      //   author: book['author'],
                      //   availableQty: book['available_qty'],
                      //   lockStatus: book['lock_status'],
                      // );
              },
            ),
                    ),
                  ),
                ),
            const SizedBox(
              height: ESizes.spaceBtwItems1,
            ),
          ],
        ),
      ),
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              tooltip: 'Scroll to Top',
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
*/
class BookTile extends StatelessWidget {
  final Map<String, dynamic> book;

  BookTile({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            book['covor_image'],
            height: 80.0,
            width: 80.0,
          ),
          const SizedBox(height: 8.0),
          Expanded(
              child: Text(
            book['book_title'],
            style: const TextStyle(
                // overflow: TextOverflow.ellipsis
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
          const SizedBox(height: 4.0),
          Expanded(child: Text(book['author'])),
          const SizedBox(height: 4.0),
          Text('Available Qty: ${book['available_qty']}'),
          const SizedBox(height: 8.0),
          Switch(
            value: book['lock_status'] == 'True',
            onChanged: (bool value) {
              // Implement logic to update lock status on the server
              // You might need to make an API call to update this status
              // based on the book['title_id'] and value (true/false)
            },
          ),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import '../../../../../common/widgets/book_contanier/book_contanier.dart';
import '../../../../../common/widgets/custom_container_button/custom_container_button.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import 'book_contaner/book_contanier.dart';
import 'e_library/e_library.dart';
import 'history/book_history.dart';
import 'issued_books/issued_books.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: true,
        title: Text(
          'Library',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          /// Search bar
          const CustomSearchContainer(
            showBackground: true,
            dark: false,
            showBorder: true,
          ),

          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          /// Three Buttons eLibrary | Issued Book | History
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomContainerButton(
                  buttonText: 'eLibrary',
                  onTap: () {
                    Get.to(() => const ELibraryScreen(),
                        curve: Curves.easeInOut,
                        transition: Transition.cupertino);
                  },
                ),
                CustomContainerButton(
                  buttonText: 'Issued Books',
                  onTap: () {
                    Get.to(() => const IssuedBooksScreen(),
                        curve: Curves.easeInOut,
                        transition: Transition.cupertino);
                  },
                ),
                CustomContainerButton(
                  buttonText: 'History',
                  onTap: () {
                    Get.to(() => const BookHistoryScreen(),
                        curve: Curves.easeInOut,
                        transition: Transition.cupertino);
                  },
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          const SizedBox(
            height: ESizes.spaceBtwItems1,
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  /// Title Heading for Books
                  const Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: TopHeading(
                            text:
                                'Unveiling Our Newest\nArrivals: Dive into\nFresh Reads',
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtwItems,
                  ),

                  /// Showcase Library Books
                  /// Showcase Library Books
                  /// Showcase Library Books
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder<List<Book>>(
                      future: ApiService.fetchBooksData(" "),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // If the Future is still running, display a loading indicator
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If the Future throws an error, display an error message
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          // If the Future is completed but no data is available
                          return Text('No books found.');
                        } else {
                          // If the Future is completed with data
                          return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 18.0,
                            ),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BookContainer(
                                imageUrl: snapshot.data![index].coverImage,
                                // Pass other required fields from the Book model
                                // You can customize as needed
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const BookContainer(imageUrl: 'assets/books/1book.jpg',),
                      const BookContainer(imageUrl: 'assets/books/1book.jpg',),
                      // CustomContainer(
                      //   imageUrl: bookImages.elementAt(0),
                      // ),
                      // CustomContainer(
                      //   imageUrl: bookImages.elementAt(1),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainer(
                        imageUrl: bookImages.elementAt(2),
                      ),
                      CustomContainer(
                        imageUrl: bookImages.elementAt(3),
                      ),
                    ],
                  ),
                  */
                  const SizedBox(
                    height: ESizes.spaceBtwItems,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final int sno;
  final String titleId;
  final String bookTitle;
  final String author;
  final String coverImage;
  final int availableQty;
  final bool lockStatus;

  Book({
    required this.sno,
    required this.titleId,
    required this.bookTitle,
    required this.author,
    required this.coverImage,
    required this.availableQty,
    required this.lockStatus,
  });
}



// Sample list of image URLs (replace these with your actual image URLs)
final List<String> bookImages = [
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

/// Correct UI code
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
// import 'package:baderia_tech_wave/common/widgets/custom_shapes/containers/search_container.dart';
// import 'package:baderia_tech_wave/utils/constants/sizes.dart';
// import '../../../../../common/widgets/book_contanier/book_contanier.dart';
// import '../../../../../common/widgets/custom_container_button/custom_container_button.dart';
// import '../../../../../common/widgets/texts/top_first_heading.dart';
// import '../../../../../utils/constants/colors.dart';
// import 'e_library/e_library.dart';
// import 'history/book_history.dart';
// import 'issued_books/issued_books.dart';
//
// class LibraryScreen extends StatelessWidget {
//   const LibraryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         backgroundColor: Colors.transparent,
//         showBackArrow: true,
//         centerTitle: true,
//         title: Text(
//           'Library',
//           style: TextStyle(
//             color: EColors.textColorPrimary1,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           /// Search bar
//           const ESearchContainer(
//             text: 'Search Books',
//           ),
//           // CustomSearchContainer(
//           //             showBackground: true,
//           //             dark: false,
//           //             showBorder: true,
//           //           ),
//
//           const SizedBox(
//             height: ESizes.spaceBtwItems,
//           ),
//
//           /// Three Buttons eLibrary | Issued Book | History
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomContainerButton(
//                   buttonText: 'eLibrary',
//                   onTap: () {
//                     Get.to(() => const ELibraryScreen(),curve: Curves.easeInOut, transition: Transition.cupertino);
//                   },
//                 ),
//                 CustomContainerButton(
//                   buttonText: 'Issued Books',
//                   onTap: () {
//                     Get.to(() => const IssuedBooksScreen(),curve: Curves.easeInOut, transition: Transition.cupertino);
//                   },
//                 ),
//                 CustomContainerButton(
//                   buttonText: 'History',
//                   onTap: () {
//                     Get.to(() => const BookHistoryScreen(),curve: Curves.easeInOut, transition: Transition.cupertino);
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Divider(),
//           ),
//           const SizedBox(
//             height: ESizes.spaceBtwItems1,
//           ),
//
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   /// Title Heading for Books
//                   const Row(
//                     children: [
//                       Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 22),
//                           child: TopHeading(
//                             text:
//                                 'Unveiling Our Newest\nArrivals: Dive into\nFresh Reads',
//                           )),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: ESizes.spaceBtwItems,
//                   ),
//
//                   /// Showcase Library Books
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CustomContainer(
//                         imageUrl: bookImages.first,
//                       ),
//                       CustomContainer(
//                         imageUrl: bookImages.elementAt(1),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: ESizes.spaceBtwItems,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CustomContainer(
//                         imageUrl: bookImages.elementAt(2),
//                       ),
//                       CustomContainer(
//                         imageUrl: bookImages.elementAt(3),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: ESizes.spaceBtwItems,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Sample list of image URLs (replace these with your actual image URLs)
// final List<String> bookImages = [
//   'assets/books/1book.jpg',
//   'assets/books/2book.jpg',
//   'assets/books/3book.jpg',
//   'assets/books/4book.jpg',
//   'assets/books/1book.jpg',
//   'assets/books/2book.jpg',
//   'assets/books/3book.jpg',
//   'assets/books/4book.jpg',
//   // Add more image URLs as needed
// ];
