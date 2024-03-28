import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Book Image with shadow
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/Backgrounds/book_loading.gif', // Placeholder image until the actual one loads
                image: widget.imageUrl,
                fit: BoxFit.contain,
                width: 80,
                height: 80,
              ),
            ),
          ),

          // Book Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'By: ${widget.author}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Available: ${widget.availableQty}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Toggle the lock status
                            bool newLockStatus = widget.lockStatus == 'True' ? false : true;

                            // Call the onTapLockButton function with the new lock status
                            widget.onTapLockButton(newLockStatus);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 26),
                            backgroundColor: widget.lockStatus == 'True'
                                ? Colors.red.shade400
                                : Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            widget.lockStatus == 'True' ? 'Locked' : 'Unlocked',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                    ],
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

/// code is fully correct
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';

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
    return Container(
      padding: EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Book Image with shadow
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Book Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: EColors.textColorPrimary1
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'By: ${widget.author}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Available: ${widget.availableQty}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Toggle the lock status
                            bool newLockStatus = widget.lockStatus == 'True' ? false : true;

                            // Call the onTapLockButton function with the new lock status
                            widget.onTapLockButton(newLockStatus);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 26),
                            backgroundColor:
                            widget.lockStatus == 'True' ? Colors.red.shade400 : Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),

                             // backgroundColor: widget.lockStatus == 'True' ? Colors.red : Colors.green,
                          ),
                          child: Text(
                            widget.lockStatus == 'True' ? 'Locked' : 'Unlocked',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                                letterSpacing: .5
                            ),
                          ),
                        ),
                      ),
                    ],
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


 */


/*
/// issue in this code when i tap double time then its Updating the lock status
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;

  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  late bool isLocked;
  bool isLoading = false;

  // Use a shared instance of BookController for all BookContainers
  final BookController controller = Get.find<BookController>();

  @override
  void initState() {
    super.initState();
    isLocked = widget.lockStatus == 'True';
  }
  Future<bool?> _showLockConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Lock'),
          content: Text('Do you want to lock the book?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed lock
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Book Image with shadow
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Book Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'By ${widget.author}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Available: ${widget.availableQty} copies',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                            setState(() {
                              isLocked = !isLocked;
                            });
                            await controller.changeLockStatus(widget.bookId, isLocked);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 30),
                            backgroundColor:
                            isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                            isLocked ? 'Locked' : 'Unlocked',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: isLocked ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   */

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                            bool? confirmLock = await _showLockConfirmationDialog();
                            if (confirmLock != null && confirmLock) {
                              setState(() {
                                isLoading = true;
                              });

                              // Change the lock status locally
                              isLocked = !isLocked;
                              await controller.changeLockStatus(widget.bookId, isLocked);

                              // After changing the lock status, send the request to the API
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 30),
                            backgroundColor:
                            isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                            isLocked ? 'Locked' : 'Unlocked',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: isLocked ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class BookController extends GetxController {
  var _lockedBooks = <String, bool>{};

  bool isBookLocked(String bookId) {
    return _lockedBooks[bookId] ?? false;
  }

  Future<void> changeLockStatus(String bookId, bool currentStatus) async {
    try {
      var newLockStatus = !currentStatus;
      _lockedBooks[bookId] = newLockStatus;
      update(); // Notify listeners

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var request = http.MultipartRequest(
          'POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'book_id': bookId,
        'lock_status': newLockStatus ? 'True' : 'False',
      });

      var headers = {
        'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}


 */


/// ------>>>>>

/*
/// the UI is not Updating when the Button is tapped
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;

  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  late bool isLocked;
  bool isLoading = false; // Add this variable for loading indicator

  @override
  void initState() {
    super.initState();
    isLocked = widget.lockStatus == 'True';
  }

  // Future<void> _callApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userId = prefs.getString('user_id') ?? '';
  //
  //   // Toggle the lock status
  //   var newLockStatus = isLocked ? 'False' : 'True';
  //
  //   setState(() {
  //     isLoading = true; // Set loading to true when the API call starts
  //   });
  //
  //   var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
  //   request.fields.addAll({
  //     'APIKEY': 'GNCS0225',
  //     'USER_ID': userId,
  //     'book_id': widget.bookId,
  //     'lock_status': newLockStatus,
  //   });
  //
  //   var headers = {
  //     'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
  //   };
  //   request.headers.addAll(headers);
  //
  //   try {
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print('API Response: ${await response.stream.bytesToString()}');
  //       // Update isLocked based on the new lock status
  //       setState(() {
  //         isLocked = !isLocked;
  //       });
  //     } else {
  //       print('API Error: ${response.reasonPhrase}');
  //     }
  //   } finally {
  //     setState(() {
  //       isLoading = false; // Set loading to false when the API call completes (either success or error)
  //     });
  //   }
  // }

  Future<void> _callApi() async {
    try {
      setState(() {
        isLoading = true;
      });

      var controller = Get.find<BookController>();
      await controller.changeLockStatus(widget.bookId, isLocked);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      init: BookController(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(12),
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
          child: Row(
            children: [
              // Book Image with shadow
              Container(
                width: 120,
                height: 120,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Book Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: EColors.textColorPrimary1
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'By ${widget.author}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Available: ${widget.availableQty} copies',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: EColors.textColorPrimary1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                await controller.changeLockStatus(widget.bookId, isLocked);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(80, 30),
                                backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                                  : Text(
                                isLocked ? 'Locked' : 'Unlocked',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: isLocked ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BookController extends GetxController {
  var _lockedBooks = <String, bool>{};

  bool isBookLocked(String bookId) {
    return _lockedBooks[bookId] ?? false;
  }

  Future<void> changeLockStatus(String bookId, bool currentStatus) async {
    try {
      var newLockStatus = !currentStatus;
      _lockedBooks[bookId] = newLockStatus;
      update();  // Notify listeners

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'book_id': bookId,
        'lock_status': newLockStatus ? 'True' : 'False',
      });

      var headers = {
        'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

 */


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;

  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  late bool isLocked;
  bool isLoading = false; // Add this variable for loading indicator

  @override
  void initState() {
    super.initState();
    isLocked = widget.lockStatus == 'True';
  }

  Future<void> _callApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    // Toggle the lock status
    var newLockStatus = isLocked ? 'False' : 'True';

    setState(() {
      isLoading = true; // Set loading to true when the API call starts
    });

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': widget.bookId,
      'lock_status': newLockStatus,
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
        // Update isLocked based on the new lock status
        setState(() {
          isLocked = !isLocked;
        });
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } finally {
      setState(() {
        isLoading = false; // Set loading to false when the API call completes (either success or error)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      init: BookController(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(12),
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
          child: Row(
            children: [
              // Book Image with shadow
              Container(
                width: 120,
                height: 120,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Book Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: EColors.textColorPrimary1
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'By ${widget.author}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Available: ${widget.availableQty} copies',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: EColors.textColorPrimary1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                await controller.changeLockStatus(widget.bookId, isLocked);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(80, 30),
                                backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                                  : Text(
                                isLocked ? 'Locked' : 'Unlocked',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: isLocked ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BookController extends GetxController {
  var _lockedBooks = <String, bool>{};

  bool isBookLocked(String bookId) {
    return _lockedBooks[bookId] ?? false;
  }

  Future<void> changeLockStatus(String bookId, bool currentStatus) async {
    var newLockStatus = !currentStatus;
    // Set the new lock status locally
    _lockedBooks[bookId] = newLockStatus;

    // Notify listeners
    update();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': bookId,
      'lock_status': newLockStatus ? 'True' : 'False',
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;

  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  late bool isLocked;
  bool isLoading = false; // Add this variable for loading indicator

  @override
  void initState() {
    super.initState();
    isLocked = widget.lockStatus == 'True';
  }

  Future<void> _callApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    // Toggle the lock status
    var newLockStatus = isLocked ? 'False' : 'True';

    setState(() {
      isLoading = true; // Set loading to true when the API call starts
    });

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': widget.bookId,
      'lock_status': newLockStatus,
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
        // Update isLocked based on the new lock status
        setState(() {
          isLocked = !isLocked;
        });
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } finally {
      setState(() {
        isLoading = false; // Set loading to false when the API call completes (either success or error)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      init: BookController(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(12),
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
          child: Row(
            children: [
              // Book Image with shadow
              Container(
                width: 120,
                height: 120,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Book Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: EColors.textColorPrimary1
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'By ${widget.author}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Available: ${widget.availableQty} copies',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: EColors.textColorPrimary1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TweenAnimationBuilder(
                              tween: Tween<double>(begin: 1, end: 0.9),
                              duration: Duration(milliseconds: 200),
                              builder: (context, scaleValue, child) {
                                return Transform.scale(
                                  scale: scaleValue,
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null // Disable button when loading
                                        : () async {
                                      await controller.changeLockStatus(widget.bookId, isLocked);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(80, 30),
                                      backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: isLoading
                                        ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                                        : Text(
                                      isLocked ? 'Locked' : 'Unlocked',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        color: isLocked ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BookController extends GetxController {
  var _lockedBooks = <String, bool>{};

  bool isBookLocked(String bookId) {
    return _lockedBooks[bookId] ?? false;
  }

  Future<void> changeLockStatus(String bookId, bool currentStatus) async {
    var newLockStatus = !currentStatus;
    // Set the new lock status locally
    _lockedBooks[bookId] = newLockStatus;

    // Notify listeners
    update();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': bookId,
      'lock_status': newLockStatus ? 'True' : 'False',
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}


 */


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class BookContainerController extends GetxController {
  var isLocked = true.obs;
  var isLoading = false.obs;

  Future<void> lockUnlockBook(String bookId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    // Toggle the lock status
    var newLockStatus = isLocked.value ? 'False' : 'True';

    isLoading.value = true; // Set loading to true when the API call starts

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': bookId,
      'lock_status': newLockStatus,
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
        // Update isLocked based on the new lock status
        isLocked.value = !isLocked.value;
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } finally {
      isLoading.value = false; // Set loading to false when the API call completes (either success or error)
    }
  }
}

class BookContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;

  BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  final controller = Get.put(BookContainerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Book Image with shadow
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Book Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: EColors.textColorPrimary1
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'By $author',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Available: $availableQty copies',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 1, end: 0.9),
                          duration: Duration(milliseconds: 200),
                          builder: (context, scaleValue, child) {
                            return Transform.scale(
                              scale: scaleValue,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Call the controller method to lock/unlock the book
                                  await controller.lockUnlockBook(bookId);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(80, 30),
                                  backgroundColor: controller.isLocked.value
                                      ? Colors.redAccent.shade100
                                      : Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Obx(() => controller.isLoading.value
                                    ? CircularProgressIndicator()
                                    : Text(
                                  controller.isLocked.value ? 'Locked' : 'Unlocked',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: controller.isLocked.value ? Colors.white : Colors.black,
                                  ),
                                )),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
*/
/// ----------

/*
/// Get x
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BookContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;

  BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      init: BookController(),
      builder: (controller) => Container(
        padding: EdgeInsets.all(12),
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
        child: Row(
          children: [
            // Book Image with shadow
            Container(
              width: 120,
              height: 120,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Book Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: EColors.textColorPrimary1),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'By $author',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Available: $availableQty copies',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EColors.textColorPrimary1,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: 1, end: 0.9),
                            duration: Duration(milliseconds: 200),
                            builder: (context, scaleValue, child) {
                              return Transform.scale(
                                scale: scaleValue,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.toggleLockStatus(bookId, lockStatus);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(80, 30),
                                    backgroundColor: controller.isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: controller.isLoading
                                      ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                                      : Text(
                                    controller.isLocked ? 'Locked' : 'Unlocked',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: controller.isLocked ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookController extends GetxController {
  bool isLoading = false;
  bool isLocked = false;

  void toggleLockStatus(String bookId, String currentLockStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    // Toggle the lock status
    var newLockStatus = currentLockStatus == 'True' ? 'False' : 'True';

    isLoading = true; // Set loading to true when the API call starts
    update();

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': bookId,
      'lock_status': newLockStatus,
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
        // Update isLocked based on the new lock status
        isLocked = !isLocked;
        update();
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } finally {
      isLoading = false; // Set loading to false when the API call completes (either success or error)
      update();
    }
  }
}


 */



/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;
  final String bookId;
  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  late bool isLocked;
  bool isLoading = false; // Add this variable for loading indicator

  @override
  void initState() {
    super.initState();
    isLocked = widget.lockStatus == 'True';
  }

  Future<void> _callApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    // Toggle the lock status
    var newLockStatus = isLocked ? 'False' : 'True';

    setState(() {
      isLoading = true; // Set loading to true when the API call starts
    });

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/lock_book'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'book_id': widget.bookId,
      'lock_status': newLockStatus,
    });

    var headers = {
      'Cookie': 'ci_session=4lajhlf2a5kdgho9a8ac4m1nhvq7g0k7; remember_code=032536b7b1a6cc5611bee1901a81b3e67537fc03.7f088c4c0016afe16e096a472ab25bf5a9f14008a8863a8dcc0817961b0c6ccb828a93b9e9756fdb6f4dfa89658c4df7d66ccaf3f0d6f85e8e688dbda00457f9'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('API Response: ${await response.stream.bytesToString()}');
        // Update isLocked based on the new lock status
        setState(() {
          isLocked = !isLocked;
        });
      } else {
        print('API Error: ${response.reasonPhrase}');
      }
    } finally {
      setState(() {
        isLoading = false; // Set loading to false when the API call completes (either success or error)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Book Image with shadow
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Book Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: EColors.textColorPrimary1
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'By ${widget.author}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Available: ${widget.availableQty} copies',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 1, end: 0.9),
                          duration: Duration(milliseconds: 200),
                          builder: (context, scaleValue, child) {
                            return Transform.scale(
                              scale: scaleValue,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLocked = !isLocked;
                                  });
                                  await _callApi();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(80, 30),
                                  backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: isLoading
                                    ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                                    : Text(
                                  isLocked ? 'Locked' : 'Unlocked',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: isLocked ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
*/


///
// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/data/api/api_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:baderia_tech_wave/utils/constants/colors.dart';
//
// class BookContainer extends StatefulWidget {
//   final String imageUrl;
//   final String title;
//   final String author;
//   final String availableQty;
//   final String lockStatus;
//   final String bookId;
//
//   const BookContainer({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.author,
//     required this.availableQty,
//     required this.lockStatus,
//     required this.bookId,
//   }) : super(key: key);
//
//   @override
//   State<BookContainer> createState() => _BookContainerState();
// }
//
// class _BookContainerState extends State<BookContainer> {
//   late bool isLocked; // State variable for the Switch
//
//   @override
//   void initState() {
//     super.initState();
//     // Set the initial state of the Switch based on the provided lock status
//     isLocked = widget.lockStatus == '1'; // Assuming lock status is '1' for locked and '0' for unlocked
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Book Image with shadow
//           Container(
//             width: 120,
//             height: 120,
//             margin: EdgeInsets.only(right: 8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               image: DecorationImage(
//                 image: NetworkImage(widget.imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           // Book Details
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: EColors.textColorPrimary1,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     'By ${widget.author}',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 11,
//                       color: Colors.black38,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     'Available: ${widget.availableQty} copies',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 13,
//                       color: EColors.textColorPrimary1,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             // Handle button tap if needed
//                             handleLockUnlockBook(widget.bookId);
//                           },
//                           child: TweenAnimationBuilder(
//                             tween: Tween<double>(begin: 1, end: 0.9),
//                             duration: Duration(milliseconds: 200),
//                             builder: (context, scaleValue, child) {
//                               return Transform.scale(
//                                 scale: scaleValue,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // Handle button press if needed
//                                     handleLockUnlockBook(widget.bookId);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     minimumSize: Size(80, 30),
//                                     backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     isLocked ? 'Locked' : 'Unlocked',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 12,
//                                       color: isLocked ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> handleLockUnlockBook(String bookId) async {
//     // Fetch user ID from local storage
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userId = prefs.getString('user_id');
//
//     if (userId != null) {
//       // Call the BookService to lock/unlock the book
//       await ApiService.lockUnlockBook(userId, bookId, !isLocked);
//
//       // Update the lock status locally
//       setState(() {
//         isLocked = !isLocked;
//       });
//     } else {
//       // Handle the case where user ID is not available
//       print('User ID not found in local storage.');
//     }
//   }
// }
//



/// Correct Code
// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/utils/constants/colors.dart';
//
// class BookContainer extends StatefulWidget {
//   final String imageUrl;
//   final String title;
//   final String author;
//   final String availableQty;
//   final String lockStatus;
//   const BookContainer({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.author,
//     required this.availableQty,
//     required this.lockStatus,
//   }) : super(key: key);
//
//   @override
//   State<BookContainer> createState() => _BookContainerState();
// }
//
// class _BookContainerState extends State<BookContainer> {
//   bool isLocked = false; // State variable for the Switch
//
//   @override
//   void initState() {
//     super.initState();
//     // Set the initial state of the Switch based on the provided lock status
//     isLocked = widget.lockStatus.toLowerCase() == 'true';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Book Image with shadow
//           Container(
//             width: 120,
//             height: 120,
//             margin: EdgeInsets.only(right: 8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               image: DecorationImage(
//                 image: NetworkImage(widget.imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           // Book Details
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: EColors.textColorPrimary1
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     'By ${widget.author}',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 11,
//                       color: Colors.black38,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     'Available: ${widget.availableQty} copies',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 13,
//                       color: EColors.textColorPrimary1,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Text(
//                       //   'Lock Status:',
//                       //   style: TextStyle(
//                       //     fontSize: 12,
//                       //   ),
//                       // ),
//
//                       // SizedBox(width: 15),
//
//                       // Transform.scale(
//                       //   scale: .7,
//                       //   child: Switch(
//                       //     value: isLocked,
//                       //     onChanged: (value) {
//                       //       setState(() {
//                       //         isLocked = value;
//                       //       });
//                       //     },
//                       //     activeColor: EColors.primary, // Change this to your preferred color
//                       //     activeTrackColor: Colors.grey.shade300,
//                       //   ),
//                       // ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             // Handle button tap if needed
//                             setState(() {
//                               isLocked = !isLocked;
//                             });
//                           },
//                           child: TweenAnimationBuilder(
//                             tween: Tween<double>(begin: 1, end: 0.9),
//                             duration: Duration(milliseconds: 200),
//                             builder: (context, scaleValue, child) {
//                               return Transform.scale(
//                                 scale: scaleValue,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // Handle button press if needed
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     minimumSize: Size(80, 30),
//                                     backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     isLocked ? 'Locked' : 'Unlocked',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 12,
//                                       color: isLocked ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       /*
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Handle button press if needed
//                           },
//                           style: ElevatedButton.styleFrom(
//                           minimumSize: Size(100, 30),
//                             backgroundColor: isLocked ? Colors.redAccent.shade100 : Colors.grey.shade200,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                           child: Text(
//                             isLocked ? 'Locked' : 'Unlocked',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: isLocked ? Colors.white : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                        */
//                     ],
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



/*
import 'package:flip_card/flip_card.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;

  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  String lockStatus = ''; // Track the book lock state

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: BookFront(imageUrl: widget.imageUrl),
      back: BookBack(
        lockStatus: widget.lockStatus,
        onToggle: () {
          // Show AlertDialog for locking or unlocking
          showDialog(
            context: context,
            builder: (context) {
              return lockStatus == "True"
                  ? UnlockBookDialog(onUnlock: unlockBook)
                  : LockBookDialog(onLock: lockBook);
            },
          );
        },
        title: widget.title,
        author: widget.author,
        availableQty: widget.availableQty,
      ),
    );
  }

  void lockBook() {
    // Show SnackBar for book locking
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book Locking process successful'),
      ),
    );
    // Update the book lock state
    setState(() {
      lockStatus = "True";
    });
  }

  void unlockBook() {
    // Show SnackBar for book unlocking
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book Unlocking process successful'),
      ),
    );
    // Update the book lock state
    setState(() {
      lockStatus = "False";
    });
  }
}

class BookFront extends StatelessWidget {
  final String imageUrl;

  const BookFront({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = 165.0;
    var height = 264.69;
    return Container(
      // width: width,
      // height: height,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Transform.rotate(
            angle: 31,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: .5,
                    spreadRadius: .5,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  'Tap Here!!!',
                  style: TextStyle(
                    color: EColors.textColorPrimary1,
                    fontFamily: 'Inter',
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookBack extends StatelessWidget {
  final VoidCallback onToggle;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;

  const BookBack(
      {Key? key,
        required this.onToggle,
        required this.title,
        required this.author,
        required this.availableQty,
        required this.lockStatus
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var width = 165.0;
    // var height = 264.69;
    final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Container(
      // width: width,
      // height: height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Book Title
            Text(
              title,
              // 'THE FIRST THREE MINUTES',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: EColors.textColorPrimary1,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),

            /// Description
            const Text(
              'Description:',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.primarySecond,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            /// Book Description here
            const Text(
              'The Book Details Here you can check the details here!!!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.textColorPrimary1,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),

            ///Author
            const Text(
              'Author:',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.primarySecond,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            /// Author Name here
            Text(
              author,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.textColorPrimary1,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),

            ///Quantity
            Row(
              children: [
                Text(
                  'Quantity:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: EColors.primarySecond,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  availableQty,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: EColors.textColorPrimary1,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lock Book:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: EColors.primarySecond,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    thumbIcon: thumbIcon,
                    activeColor: EColors.primarySecond,
                    value: lockStatus == "True",
                    // value: lockStatus,
                    onChanged: (value) {
                      onToggle();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LockBookDialog extends StatelessWidget {
  final VoidCallback onLock;

  const LockBookDialog({Key? key, required this.onLock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Lock Book'),
      content: const Text('Do you want to lock the book?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onLock();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

class UnlockBookDialog extends StatelessWidget {
  final VoidCallback onUnlock;

  const UnlockBookDialog({Key? key, required this.onUnlock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unlock Book'),
      content: const Text('Do you want to unlock the book?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onUnlock();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';

class BookContainer extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;

  const BookContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.availableQty,
    required this.lockStatus,
  }) : super(key: key);

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  String lockStatus = ''; // Track the book lock state

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: BookFront(imageUrl: widget.imageUrl),
      back: BookBack(
        lockStatus: widget.lockStatus,
        onToggle: () {
          // Show AlertDialog for locking or unlocking
          showDialog(
            context: context,
            builder: (context) {
              return lockStatus == "True"
                  ? UnlockBookDialog(onUnlock: unlockBook)
                  : LockBookDialog(onLock: lockBook);
            },
          );
        },
        title: widget.title,
        author: widget.author,
        availableQty: widget.availableQty,
      ),
    );
  }

  void lockBook() {
    // Show SnackBar for book locking
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book Locking process successful'),
      ),
    );
    // Update the book lock state
    setState(() {
      lockStatus = "True";
    });
  }

  void unlockBook() {
    // Show SnackBar for book unlocking
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book Unlocking process successful'),
      ),
    );
    // Update the book lock state
    setState(() {
      lockStatus = "False";
    });
  }
}

class BookFront extends StatelessWidget {
  final String imageUrl;

  const BookFront({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = 165.0;
    var height = 264.69;
    return Container(
      // width: width,
      // height: height,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Transform.rotate(
            angle: 31,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: .5,
                    spreadRadius: .5,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  'Tap Here!!!',
                  style: TextStyle(
                    color: EColors.textColorPrimary1,
                    fontFamily: 'Inter',
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookBack extends StatelessWidget {
  final VoidCallback onToggle;
  final String title;
  final String author;
  final String availableQty;
  final String lockStatus;

  const BookBack(
      {Key? key,
      required this.onToggle,
      required this.title,
      required this.author,
      required this.availableQty,
        required this.lockStatus
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var width = 165.0;
    // var height = 264.69;
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Container(
      // width: width,
      // height: height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Book Title
            Text(
              title,
              // 'THE FIRST THREE MINUTES',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: EColors.textColorPrimary1,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),

            /// Description
            const Text(
              'Description:',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.primarySecond,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            /// Book Description here
            const Text(
              'The Book Details Here you can check the details here!!!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.textColorPrimary1,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),

            ///Author
            const Text(
              'Author:',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.primarySecond,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            /// Author Name here
            Text(
              author,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: EColors.textColorPrimary1,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),

            ///Quantity
            Row(
              children: [
                Text(
                  'Quantity:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: EColors.primarySecond,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  availableQty,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: EColors.textColorPrimary1,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lock Book:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: EColors.primarySecond,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    thumbIcon: thumbIcon,
                    activeColor: EColors.primarySecond,
                    value: lockStatus == "True",
                    // value: lockStatus,
                    onChanged: (value) {
                      onToggle();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LockBookDialog extends StatelessWidget {
  final VoidCallback onLock;

  const LockBookDialog({Key? key, required this.onLock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Lock Book'),
      content: const Text('Do you want to lock the book?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onLock();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

class UnlockBookDialog extends StatelessWidget {
  final VoidCallback onUnlock;

  const UnlockBookDialog({Key? key, required this.onUnlock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unlock Book'),
      content: const Text('Do you want to unlock the book?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onUnlock();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
*/
