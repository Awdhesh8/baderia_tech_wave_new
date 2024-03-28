import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../../../../../common/widgets/book_contanier/customBookContanier/custom_book_contanier.dart';

class CustomBookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;
  final Function(bool newLockStatus) onTapLockButton;
  const CustomBookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
    required this.onTapLockButton,
  }) : super(key: key);

  @override
  State<CustomBookContainer> createState() => _CustomBookContainerState();
}

class _CustomBookContainerState extends State<CustomBookContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

      Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 20, bottom: 25, top: 15),
          child: Stack(
            children: [
              CustomPaint(
                painter: MyPainter(),
                child: Container(
                  width : MediaQuery.of(context).size.width * 0.82,
                   height: MediaQuery.of(context).size.width * 0.55,
                   //  width: 290.0, // Adjust the width as needed
                   // height: 200.0, // Adjust the height as needed
                   //
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 125,
                                    // height: 50,
                                    child: Text(
                                        widget.title,
                                      style: TextStyle(
                                        color: EColors.textColorPrimary1,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: Text(
                                      'By:${widget.author}',
                                         // 'Author:  ${widget.author}',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 170,
                                    height: 50,
                                    child: Text(
                                      'Available: ${widget.availableQty}',
                                        // 'Available: ${widget.availableQty} copies',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.03, // Adjust the value as needed
                top: MediaQuery.of(context).size.height * 0.06, // Adjust the value as needed
                // right: 10,
                // top: 55,
                //
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.34,
                  // height: 130,
                  // width: 122,
                  //
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.06, // Adjust the value as needed
                top: MediaQuery.of(context).size.height * 0.025, // Adjust the value as needed
                //   right: 20,
                // top: 25,

                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.28,
                  //  height: 145,
                  // width: 100,
                  //
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 0,
                child:
                // Container(
                //   width: 130,
                //   height: 36,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(
                //           blurRadius: 1,
                //           color: Colors.black12
                //       ),
                //     ],
                //   ),
                //   child: Center(child: Text('Download Now!!!')),
                // ),
                GestureDetector(
                  onTap: () {
                    // Toggle the lock status
                    bool newLockStatus = widget.lockStatus == 'True' ? false : true;

                    // Call the onTapLockButton function with the new lock status
                    widget.onTapLockButton(newLockStatus);
                  },
                  child: Container(
                    width: 130,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: Colors.black12
                        )
                      ],
                      color: widget.lockStatus == 'True' ? Colors.redAccent.shade100 : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        widget.lockStatus == 'True' ? 'Locked' : 'Unlocked',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      );
  }
}

/*
class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;
  final Function(bool newLockStatus) onTapLockButton;
  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
    required this.onTapLockButton,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 32, bottom: 25, top: 15),
          child: Stack(
            children: [
              CustomPaint(
                painter: MyPainter(),
                child: Container(
                  width: 360.0, // Adjust the width as needed
                  height: 200.0, // Adjust the height as needed
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    height: 50,
                                    child: Text(
                                      'Custom Paint fsdjkfhsdhfsjkfhsjkdfhed Container',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 170,
                                    height: 50,
                                    child: Text(
                                      'Author:  sfsdfsjfksjafkljklj  kl',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 170,
                                    height: 50,
                                    child: Text(
                                      'Available : 25 copies',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 55,
                child: Container(
                  height: 140,
                  width: 135,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Positioned(
                right: 22,
                top: 25,
                child: Container(
                  height: 155,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/1book.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 0,
                child: Container(
                  width: 166,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          color: Colors.black12
                      ),
                    ],
                  ),
                  child: Center(child: Text('Download Now!!!')),
                ),
              ),
            ],
          ),
        ),
      );
  }
}


 */


/*
  Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 32, bottom: 25, top: 15),
                child: Stack(
                  children: [
                  CustomPaint(
                    painter: MyPainter(),
                    child: Container(
                      width: 360.0, // Adjust the width as needed
                      height: 200.0, // Adjust the height as needed
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18, top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Custom Painted Container',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Author: William',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Availability : 15',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                    Positioned(
                      right: 10,
                      top: 55,
                      child: Container(
                        height: 140,
                        width: 135,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 22,
                      top: 25,
                      child: Container(
                        height: 155,
                        width: 110,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/1book.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      bottom: 0,
                      child: Container(
                        width: 166,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.black12
                            ),
                          ],
                        ),
                        child: Center(child: Text('Download Now!!!')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
 */