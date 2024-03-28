import 'package:flutter/material.dart';
import '../../../../../../utils/constants/colors.dart';
import '../wdgets/two_side_rounded_button.dart';

class ReadingListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final double? rating;
  final Function? pressDetails;
  final Function? pressRead;

  const ReadingListCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    this.rating,
    this.pressDetails,
    this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4; // Adjust as needed
    final cardHeight = cardWidth * 1.4; // Adjust as needed

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: cardHeight,
      width: cardWidth,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: cardHeight - 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 33,
                //     color: EColors.kShadowColor,
                //   ),
                // ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              width: cardWidth * 0.5, // Adjust as needed
            ),
          ),
          Positioned(
            top: cardHeight * 0.56,
            child: Container(
              height: cardHeight * 0.3,
              width: cardWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: cardWidth * 0.12),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: EColors.kBlackColor),
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: author,
                            style: TextStyle(
                              color: EColors.kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pressDetails as void Function()?,
                        child: Container(
                          width: cardWidth * 0.5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text("Details"),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "Read",
                          press: pressRead as void Function()?,
                          radious: 2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import '../../../../../../utils/constants/colors.dart';
import '../wdgets/two_side_rounded_button.dart';

class ReadingListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final double? rating;
  final Function? pressDetails;
  final Function? pressRead;

  const ReadingListCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    this.rating,
    this.pressDetails,
    this.pressRead, required availableQty, required lockStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, right: 10),
      height: 285,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 33,
                //     color: EColors.kShadowColor,
                //   ),
                // ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              width: 100,
            ),
          ),
          // Positioned(
          //   top: 35,
          //   right: 10,
          //   child: Column(
          //     children: <Widget>[
          //       IconButton(
          //         icon: Icon(
          //           Icons.favorite_border,
          //         ),
          //         onPressed: () {},
          //       ),
          //       BookRating(score: rating),
          //     ],
          //   ),
          // ),
          Positioned(
            top: 160,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: EColors.kBlackColor),
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: author,
                            style: TextStyle(
                              color: EColors.kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pressDetails as void Function()?,
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text("Details"),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "Read",
                          press: pressRead as void Function()?, radious: 2,
                        ),
                      )
                    ],
                  )
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