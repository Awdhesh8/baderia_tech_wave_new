import 'package:flutter/material.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../e_library/book_widget/e_book_widget.dart';

class IssuedBookDetailsContainer extends StatefulWidget {
  final String title;
  final String author;
  final String issueDateTime;
  final String imageUrl;

  IssuedBookDetailsContainer({
    Key? key,
    required this.title,
    required this.author,
    required this.issueDateTime, required this.imageUrl,
  }) : super(key: key);

  @override
  State<IssuedBookDetailsContainer> createState() =>
      _IssuedBookDetailsContainerState();
}

class _IssuedBookDetailsContainerState
    extends State<IssuedBookDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 120.0,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
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
                      ),


                    ],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        BookTitleWidget(title: widget.title),
                        const SizedBox(
                          height: ESizes.spaceBtwItemsHeadings,
                        ),
                        // AuthorLabelWidget(),
                        // const SizedBox(height: 4),
                        AuthorNameWidget(author: widget.author),
                        const SizedBox(
                          height: ESizes.spaceBtwItemsHeadings,
                        ),
                        IssueDate(
                          issueDate: widget.issueDateTime,
                        ),
                        const SizedBox(
                          height: ESizes.spaceBtwItemsHeadings,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import '../../../../../../../common/widgets/book_contanier/book_contanier.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../e_library/book_widget/e_book_widget.dart';

class IssuedBookDetailsContainer extends StatelessWidget {
  final Map<String, dynamic> bookData;

  const IssuedBookDetailsContainer({Key? key, required this.bookData}) : super(key: key);

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
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookTitleWidget(title: widget.title),
                    // const SizedBox(
                    //   height: ESizes.spaceBtwItems,
                    // ),
                    // BookDescriptionWidget(description: bookData['description']),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
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
                    IssueDate(issueDate: widget.issueDateTime,
                    ),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                    /*
                    IssueTime(issueTime: bookData['issueTime'],
                    ),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                     */

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
