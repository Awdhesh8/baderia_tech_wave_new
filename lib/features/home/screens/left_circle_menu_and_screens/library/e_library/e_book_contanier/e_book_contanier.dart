import 'package:flutter/material.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../book_widget/e_book_widget.dart';

class EBookDetailsContainer extends StatefulWidget {
  // final Map<String, dynamic> bookData;
  final String imageUrl;
  final String title;
  final String author;
  final String downloadEBook;

  const EBookDetailsContainer({
    Key? key,
    required this.title,
    required this.author,
    required this.downloadEBook,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<EBookDetailsContainer> createState() => _EBookDetailsContainerState();
}

class _EBookDetailsContainerState extends State<EBookDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*


                         Container(
                        width: 120.69,
                        height: 120.69,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.imageUrl,
                            ),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                       */

                      Container(
                        width: 120.0,
                        height: 120,
                        decoration: ShapeDecoration(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(75),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image: $error');
                              return Container(
                                width: 130.0,
                                height: 144.69,
                                decoration: ShapeDecoration(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(75),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Book cover not available',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),


                    ],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BookTitleWidget(title: widget.title),
                        const SizedBox(
                          height: ESizes.spaceBtwItemsHeadings,
                        ),

                        // AuthorLabelWidget(),
                        // const SizedBox(height: 4),
                        AuthorNameWidget(author: widget.author),
                        const SizedBox(
                          height: ESizes.spaceBtwItems1,
                        ),
                         DownloadPDFButtonWidget(downloadLink: widget.downloadEBook),
                      ],
                    ),
                  ),
                ],
              ),
              // Divider(),
              // DownloadPDFButtonWidget(downloadLink: widget.downloadEBook),

            ],
          ),
        ),
      ),
    );
  }
}



/// Correct Code with Fetching api's
/*
import 'package:flutter/material.dart';
import '../../../../../../../common/widgets/book_contanier/book_contanier.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../book_widget/e_book_widget.dart';

class EBookDetailsContainer extends StatefulWidget {
  // final Map<String, dynamic> bookData;
  final String imageUrl;
  final String title;
  final String author;
  final String downloadEBook;

  const EBookDetailsContainer({
    Key? key,
    required this.title,
    required this.author,
    required this.downloadEBook,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<EBookDetailsContainer> createState() => _EBookDetailsContainerState();
}

class _EBookDetailsContainerState extends State<EBookDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10.40,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Column(
                children: [
                   Container(
                     width: 130.0,
                     height: 144.69,
                      child: Image.network(
                        widget.imageUrl,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Container(
                            width: 130.0,
                            height: 144.69,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                'Book cover not available',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  /*
                  // Check if imageUrl is empty
                  widget.imageUrl.isNotEmpty
                      ? Container(
                          width: 165.0,
                          height: 264.69,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      : Container(
                          width: 125.0,
                          height: 164.69,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              'Book cover not available',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                   */
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookTitleWidget(title: widget.title),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                    // BookDescriptionWidget(description: bookData['description']),
                    // const SizedBox(
                    //   height: ESizes.spaceBtwItems,
                    // ),
                    AuthorLabelWidget(),
                    const SizedBox(height: 4),
                    AuthorNameWidget(author: widget.author),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                    // AvailableQuantityWidget(
                    //     availableQty: bookData['availableQty']),
                    // const SizedBox(
                    //   height: ESizes.spaceBtwItems,
                    // ),

                    DownloadPDFButtonWidget(downloadLink: widget.downloadEBook),
                    // DownloadPDFButtonWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/// Other Random code
/*
import 'package:flutter/material.dart';
import '../../../../../../../common/widgets/book_contanier/book_contanier.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../book_widget/e_book_widget.dart';

class EBookDetailsContainer extends StatelessWidget {
  final Map<String, dynamic> bookData;

  const EBookDetailsContainer({Key? key, required this.bookData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10.40,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Column(
                children: [
                  CustomContainer(
                    imageUrl: bookData['imageUrl'] ?? 'assets/books/1book.jpg',
                    height: 200,
                    width: 132,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookTitleWidget(title: bookData['title']),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                    BookDescriptionWidget(description: bookData['description']),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                    AuthorLabelWidget(),
                    const SizedBox(height: 4),
                    AuthorNameWidget(author: bookData['author']),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                    AvailableQuantityWidget(
                        availableQty: bookData['availableQty']),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),

                    DownloadPDFButtonWidget(
                        downloadLink: bookData['downloadLink']),
                    // DownloadPDFButtonWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */
