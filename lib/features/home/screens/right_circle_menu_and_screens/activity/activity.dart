import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/api/api_services.dart';

class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;
  final RxInt currentIndex = 0.obs; // Define currentIndex as RxInt

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  void fetchEvents() async {
    try {
      final events = await ApiService.fetchEventData();
      eventData.assignAll(events);
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  void initPageController() {
    pageController = PageController(viewportFraction: 0.8);
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    controller.initPageController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.eventData.isEmpty) {
          // Show shimmer effect while waiting for API response
          return ShimmerList();
        } else {
          // Once API response is received, show actual data
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: controller.eventData.map((event) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          event.image,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.event,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Venue: ${event.venue}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Date: ${event.date}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Time: ${event.time}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }
      }),
    );
  }
}

/*
class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    controller.initPageController();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.eventData.isEmpty) {
          // Show shimmer effect while waiting for API response
          return ShimmerList();
        } else {
          // Once API response is received, show actual data
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 35),
                child: SizedBox(
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.eventData.map((event) {
                        final int index =
                        controller.eventData.indexOf(event);
                        return GestureDetector(
                          onTap: () {
                            controller.pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  '${event.event}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  width: 10,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: PageView.builder(
                  clipBehavior: Clip.none,
                  controller: controller.pageController,
                  itemCount: controller.eventData.length,
                  onPageChanged: (index) {
                    controller.currentIndex.value = index;
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(8, 20),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(32),
                                bottom: Radius.circular(32)),
                            child: Image.network(
                              controller.eventData[index].image,
                              height: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: CardContent(
                              event: controller.eventData[index].event,
                              venue: controller.eventData[index].venue,
                              date: controller.eventData[index].date,
                              time: controller.eventData[index].time,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
 */

/*
class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    controller.initPageController();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.eventData.isEmpty) {
          // Show shimmer effect while waiting for API response
          return ShimmerList();
        } else {
          // Once API response is received, show actual data
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 35),
                child: SizedBox(
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.eventData.map((event) {
                        final int index =
                        controller.eventData.indexOf(event);
                        return GestureDetector(
                          onTap: () {
                            controller.pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  '${event.event}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  width: 10,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: PageView.builder(
                  clipBehavior: Clip.none,
                  controller: controller.pageController,
                  itemCount: controller.eventData.length,
                  onPageChanged: (index) {
                    controller.currentIndex.value = index;
                  },
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: controller.pageController,
                      builder: (context, child) {
                        double pageOffset = 0;
                        if (controller.pageController
                            .position.haveDimensions) {
                          pageOffset = controller.pageController.page! -
                              index.toDouble();
                        }
                        double gauss = math.exp(-(math.pow(
                            (pageOffset.abs() - 0.5), 2) /
                            0.08));
                        return Transform.translate(
                          offset: Offset(
                              -32 * gauss * pageOffset.sign, 0),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(8, 20),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(32),
                                      bottom: Radius.circular(32)),
                                  child: Image.network(
                                    controller.eventData[index].image,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.56,
                                    alignment:
                                    Alignment(-pageOffset.abs(), 0),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(child: child!),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Expanded(
                            child: CardContent(
                              event: controller.eventData[index].event,
                              venue: controller.eventData[index].venue,
                              date: controller.eventData[index].date,
                              time: controller.eventData[index].time,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
 */

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: List.generate(
              3,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          Column(
            children: List.generate(
              5,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
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

class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              event,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter'
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              venue,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontFamily: 'Inter'
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$date at $time',
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontFamily: 'Inter'
              ),
            ),
          ),
        ],
      ),
    );
  }
}



/// ----  pARALLEX IS WORKING FINE
/*
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}


class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.8);
    // Fetch your data from the JSON or any other source
    final jsonData = [
      {
        "event": "Vibrant Garba Night",
        "venue": "City Square",
        "date": "15-09-2024",
        "time": "06:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Navratri Extravaganza",
        "venue": "Community Hall",
        "date": "18-10-2024",
        "time": "07:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Global Fusion Garba",
        "venue": "Grand Plaza",
        "date": "22-09-2024",
        "time": "06:30 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Unity Garba Fest",
        "venue": "Town Hall",
        "date": "25-09-2024",
        "time": "08:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Diverse Garba Celebration",
        "venue": "Cultural Center",
        "date": "28-09-2024",
        "time": "07:30 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      }
    ];

    // Parse JSON data and add to eventData list
    eventData.addAll(jsonData.map((data) => EventData.fromJson(data)));

    super.onInit();
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 35),
            child: SizedBox(
              height: 40,
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.eventData.map((event) {
                      final int index = controller.eventData.indexOf(event);
                      return GestureDetector(
                        onTap: () {
                          controller.pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Obx(() => Column(
                            children: [
                              Text(
                                '${event.event}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 10,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: controller.currentIndex.value == index ? Colors.black : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          )),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: controller.pageController,
              itemCount: controller.eventData.length,
              onPageChanged: (index) {
                controller.currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: controller.pageController,
                  builder: (context, child) {
                    double pageOffset = 0;
                    if (controller.pageController.position.haveDimensions) {
                      pageOffset = controller.pageController.page! -
                          index.toDouble();
                    }
                    double gauss = math.exp(-(math.pow(
                        (pageOffset.abs() - 0.5), 2) /
                        0.08));
                    return Transform.translate(
                      offset: Offset(
                          -32 * gauss * pageOffset.sign, 0),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 24),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(8, 20),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32), bottom: Radius.circular(32)),
                              child: Image.asset(
                                controller.eventData[index].image,
                                height:
                                MediaQuery.of(context).size.height *
                                    0.56,
                                alignment:
                                Alignment(-pageOffset.abs(), 0),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(child: child!),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Expanded(
                        child: CardContent(
                          event: controller.eventData[index].event,
                          venue: controller.eventData[index].venue,
                          date: controller.eventData[index].date,
                          time: controller.eventData[index].time,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              event,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter'
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              venue,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontFamily: 'Inter'
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$date at $time',
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontFamily: 'Inter'
              ),
            ),
          ),
        ],
      ),
    );
  }
}


 */

/// -------------------------------------------------->>>>>>>>>>>>

/*
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:iconsax/iconsax.dart';

class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.8);
    // Fetch your data from the JSON or any other source
    final jsonData = [
      {
        "event": "Vibrant Garba Night",
        "venue": "City Square",
        "date": "15-09-2024",
        "time": "06:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Navratri Extravaganza",
        "venue": "Community Hall",
        "date": "18-10-2024",
        "time": "07:00 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      },
      {
        "event": "Global Fusion Garba",
        "venue": "Grand Plaza",
        "date": "22-09-2024",
        "time": "06:30 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Unity Garba Fest",
        "venue": "Town Hall",
        "date": "25-09-2024",
        "time": "08:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Diverse Garba Celebration",
        "venue": "Cultural Center",
        "date": "28-09-2024",
        "time": "07:30 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      }
    ];

    // Parse JSON data and add to eventData list
    eventData.addAll(jsonData.map((data) => EventData.fromJson(data)));

    super.onInit();
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        surfaceTintColor: Colors.transparent,
        showBackArrow: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.eventData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                              '${controller.eventData[index].event}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Inter',
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 10,
                              height: 3,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == index ? Colors.black : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.eventData.length,
                onPageChanged: (index) {
                  controller.currentIndex.value = index;
                },
                itemBuilder: (context, index) {
                  final event = controller.eventData[index];
                  return GestureDetector(
                    onTap: () {
                      // Open full-screen image view
                      Get.to(FullScreenImageView(imageUrl: event.image));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                event.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.event,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Venue: ${event.venue}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Date: ${event.date} at ${event.time}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Close full-screen image view
            Get.back();
          },
          child: Hero(
            tag: imageUrl,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}


class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            event,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter'
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            venue,
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontFamily: 'Inter'
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$date at $time',
            style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                fontFamily: 'Inter'
            ),
          ),
        ),
      ],
    );
  }
}
class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'image',
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Iconsax.close_circle,
                            color: Colors.white,
                          ))),
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 */

/*
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.8);
    // Fetch your data from the JSON or any other source
    final jsonData = [
      {
        "event": "Vibrant Garba Night",
        "venue": "City Square",
        "date": "15-09-2024",
        "time": "06:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Navratri Extravaganza",
        "venue": "Community Hall",
        "date": "18-10-2024",
        "time": "07:00 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      },
      {
        "event": "Global Fusion Garba",
        "venue": "Grand Plaza",
        "date": "22-09-2024",
        "time": "06:30 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Unity Garba Fest",
        "venue": "Town Hall",
        "date": "25-09-2024",
        "time": "08:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Diverse Garba Celebration",
        "venue": "Cultural Center",
        "date": "28-09-2024",
        "time": "07:30 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      }
    ];

    // Parse JSON data and add to eventData list
    eventData.addAll(jsonData.map((data) => EventData.fromJson(data)));

    super.onInit();
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 35),
            child: SizedBox(
              height: 40,
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.eventData.map((event) {
                      final int index = controller.eventData.indexOf(event);
                      return GestureDetector(
                        onTap: () {
                          controller.pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Obx(() => Column(
                            children: [
                              Text(
                                '${event.event}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 10,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: controller.currentIndex.value == index ? Colors.black : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          )),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: PageView.builder(

              clipBehavior: Clip.none,
              controller: controller.pageController,
              itemCount: controller.eventData.length,
              onPageChanged: (index) {
                controller.currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: controller.pageController,
                  builder: (context, child) {
                    double pageOffset = 0;
                    if (controller.pageController.position.haveDimensions) {
                      pageOffset = controller.pageController.page! -
                          index.toDouble();
                    }
                    double gauss = math.exp(-(math.pow(
                        (pageOffset.abs() - 0.5), 2) /
                        0.08));
                    return Transform.translate(
                      offset: Offset(
                          -32 * gauss * pageOffset.sign, 0),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(8, 20),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32)),
                              child: Image.asset(
                                controller.eventData[index].image,
                                height:
                                MediaQuery.of(context).size.height *
                                    0.4,
                                alignment:
                                Alignment(-pageOffset.abs(), 0),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(child: child!),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Expanded(
                        child: CardContent(
                          event: controller.eventData[index].event,
                          venue: controller.eventData[index].venue,
                          date: controller.eventData[index].date,
                          time: controller.eventData[index].time,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            event,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            venue,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
                fontFamily: 'Inter'
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$date at $time',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
                fontFamily: 'Inter'
            ),
          ),
        ),
      ],
    );
  }
}



 */


/*
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.8);
    // Fetch your data from the JSON or any other source
    final jsonData = [
      {
        "event": "Vibrant Garba Night",
        "venue": "City Square",
        "date": "15-09-2024",
        "time": "06:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Navratri Extravaganza",
        "venue": "Community Hall",
        "date": "18-10-2024",
        "time": "07:00 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      },
      {
        "event": "Global Fusion Garba",
        "venue": "Grand Plaza",
        "date": "22-09-2024",
        "time": "06:30 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Unity Garba Fest",
        "venue": "Town Hall",
        "date": "25-09-2024",
        "time": "08:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      },
      {
        "event": "Diverse Garba Celebration",
        "venue": "Cultural Center",
        "date": "28-09-2024",
        "time": "07:30 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      }
    ];

    // Parse JSON data and add to eventData list
    eventData.addAll(jsonData.map((data) => EventData.fromJson(data)));

    super.onInit();
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.eventData.map((event) {
                    return GestureDetector(
                      onTap: () {
                        controller.pageController.animateToPage(
                          controller.eventData.indexOf(event),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          event.event,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          Expanded(
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: controller.pageController,
              itemCount: controller.eventData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullScreenImage(
                              image: controller.eventData[index].image,
                            ),
                          ),
                        );
                      },
                  child: AnimatedBuilder(
                    animation: controller.pageController,
                    builder: (context, child) {
                      double pageOffset = 0;
                      if (controller.pageController.position.haveDimensions) {
                        pageOffset = controller.pageController.page! -
                            index.toDouble();
                      }
                      double gauss = math.exp(-(math.pow(
                          (pageOffset.abs() - 0.5), 2) /
                          0.08));
                      return Transform.translate(
                        offset: Offset(
                            -32 * gauss * pageOffset.sign, 0),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(8, 20),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(32)),
                                child: Image.asset(
                                  '${controller.eventData[index].image}',
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.6,
                                  alignment:
                                  Alignment(-pageOffset.abs(), 0),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Expanded(child: child!),

                            ],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Expanded(
                          child: CardContent(
                            event: controller.eventData[index].event,
                            venue: controller.eventData[index].venue,
                            date: controller.eventData[index].date,
                            time: controller.eventData[index].time,
                          ),
                        ),

                      ],
                    ),

                  ),

                );
              },

            ),

          ),

        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            event,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            venue,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$date at $time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}

 */

/*
class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'image',
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Iconsax.close_circle,
                            color: Colors.white,
                          ))),
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 */




/*
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';


class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.8);
    // Fetch your data from the JSON or any other source
    eventData.addAll([
      EventData.fromJson({
        "event": "Vibrant Garba Night",
        "venue": "City Square",
        "date": "15-09-2024",
        "time": "06:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      }),
      EventData.fromJson({
        "event": "Navratri Extravaganza",
        "venue": "Community Hall",
        "date": "18-10-2024",
        "time": "07:00 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      }),
    ]);
    super.onInit();
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.eventData.map((event) {
                    return GestureDetector(
                      onTap: () {
                        controller.pageController.animateToPage(
                          controller.eventData.indexOf(event),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          event.event,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          Expanded(
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: controller.pageController,
              itemCount: controller.eventData.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: controller.pageController,
                  builder: (context, child) {
                    double pageOffset = 0;
                    if (controller.pageController.position.haveDimensions) {
                      pageOffset = controller.pageController.page! -
                          index.toDouble();
                    }
                    double gauss = math.exp(-(math.pow(
                        (pageOffset.abs() - 0.5), 2) /
                        0.08));
                    return Transform.translate(
                      offset: Offset(
                          -32 * gauss * pageOffset.sign, 0),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(8, 20),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32)),
                              child: Image.asset(
                                controller.eventData[index].image,
                                height:
                                MediaQuery.of(context).size.height *
                                    0.6,
                                alignment:
                                Alignment(-pageOffset.abs(), 0),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(child: child!),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Expanded(
                        child: CardContent(
                          event: controller.eventData[index].event,
                          venue: controller.eventData[index].venue,
                          date: controller.eventData[index].date,
                          time: controller.eventData[index].time,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            event,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            venue,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$date at $time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}


 */




/*
class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ActivityController extends GetxController {
  final RxList<EventData> eventData = <EventData>[].obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.8);
    // Fetch your data from the JSON or any other source
    eventData.addAll([
      EventData.fromJson({
        "event": "Vibrant Garba Night",
        "venue": "City Square",
        "date": "15-09-2024",
        "time": "06:00 pm",
        "image": "assets/Backgrounds/activity1.jpg"
      }),
      EventData.fromJson({
        "event": "Navratri Extravaganza",
        "venue": "Community Hall",
        "date": "18-10-2024",
        "time": "07:00 pm",
        "image": "assets/Backgrounds/activity2.jpg"
      }),
    ]);
    super.onInit();
  }
}

class Activity extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Obx(
              () => PageView.builder(
            clipBehavior: Clip.none,
            controller: controller.pageController,
            itemCount: controller.eventData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenImage(
                        image: controller.eventData[index].image,
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: controller.pageController,
                      builder: (context, child) {
                        double pageOffset = 0;
                        if (controller.pageController.position.haveDimensions) {
                          pageOffset = controller.pageController.page! -
                              index.toDouble();
                        }
                        double gauss = math.exp(
                            -(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));
                        return Transform.translate(
                          offset: Offset(-32 * gauss * pageOffset.sign, 0),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(8, 20),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Hero(
                                  tag: 'image$index',
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(32)),
                                    child: Image.asset(
                                      controller.eventData[index].image,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.5,
                                      alignment:
                                      Alignment(-pageOffset.abs(), 0),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(child: child!),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Expanded(
                            child: CardContent(
                              event: controller.eventData[index].event,
                              venue: controller.eventData[index].venue,
                              date: controller.eventData[index].date,
                              time: controller.eventData[index].time,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(

                            ),
                            child: IconButton(
                              icon: Icon(Icons.remove_red_eye, color: Colors.white,),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullScreenImage(
                                      image: controller.eventData[index].image,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'image',
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Iconsax.close_circle,
                            color: Colors.white,
                          ))),
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            event,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            venue,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$date at $time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}


 */




/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class EventData {
  final String event;
  final String venue;
  final String date;
  final String time;
  final String image;

  EventData({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class Activity extends StatefulWidget {
  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final List<EventData> eventData = [

    EventData.fromJson({
      "event": "Vibrant Garba Night",
      "venue": "City Square",
      "date": "15-09-2024",
      "time": "06:00 pm",
      "image": "assets/Backgrounds/activity1.jpg"
    }),
    EventData.fromJson({
      "event": "Navratri Extravaganza",
      "venue": "Community Hall",
      "date": "18-10-2024",
      "time": "07:00 pm",
      "image": "assets/Backgrounds/activity2.jpg"
    }),
  ];

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: PageView.builder(
          clipBehavior: Clip.none,
          controller: pageController,
          itemCount: eventData.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: pageController,
              builder: (context, child) {
                double pageOffset = 0;
                if (pageController.position.haveDimensions) {
                  pageOffset = pageController.page! - index;
                }
                double gauss =
                math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));
                return Transform.translate(
                  offset: Offset(-32 * gauss * pageOffset.sign, 0),
                  child: Container(
                    margin:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(8, 20),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(32)),
                          child: Image.asset(
                            '${eventData[index].image}',
                            height: MediaQuery.of(context).size.height * 0.3,
                            alignment: Alignment(-pageOffset.abs(), 0),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(child: child!),
                      ],
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Expanded(
                    child: CardContent(
                      event: eventData[index].event,
                      venue: eventData[index].venue,
                      date: eventData[index].date,
                      time: eventData[index].time,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String event;
  final String venue;
  final String date;
  final String time;

  const CardContent({
    required this.event,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            event,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            venue,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$date at $time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}


 */

// import 'package:flutter/material.dart';
// import '../../../../../common/widgets/appbar/appbar.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
//
// class Activity extends StatelessWidget {
//   const Activity({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: GAppBar(
//         backgroundColor: Colors.transparent,
//         showBackArrow: true,
//         title: Text(
//           'Activities',
//           style: TextStyle(
//             fontSize: ESizes.appTitle,
//             fontFamily: 'Inter',
//             color: EColors.primary,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//
//
//         ],
//       ),
//     );
//   }
// }
//

/// Activity in Tabb-ar
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/activity/widget/dot_indicator.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: false,
        title: Text(
            'Activities',
            style: TextStyleClass.appBarTextStyle
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: TabBarView(
                      children: [
                        // Content for Category 1
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // StackContainer(),
                              //  ContainerStack(),
                              SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  color: Colors.red.shade50,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  color: Colors.blue.shade50,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  color: Colors.red.shade50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Content for Category 2
                        Stack(
                          children: [
                            Container(
                              child: const Center(
                                child: Text('Category 2 content'),
                              ),
                            ),
                          ],
                        ),
                        // Content for Category 3
                        Container(
                          child: const Center(
                            child: Text('Category 3 content'),
                          ),
                        ),
                        // Add more TabBarView children as needed
                        Container(
                          child: const Center(
                            child: Text('Category 4 content'),
                          ),
                        ),
                        // Add more TabBarView children as needed
                        Container(
                          child: const Center(
                            child: Text('Category 5 content'),
                          ),
                        ),
                        // Add more TabBarView children as needed
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: const BoxConstraints.expand(
                            height: 50, width: double.maxFinite),
                        child: const TabBar(
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicator: DotTabIndicator(
                            color: EColors.primary,
                            radius: 4,
                          ),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Global Youth Fest 2023'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Global College Yoga Day'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Engineering'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Category 4'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Tab(text: 'Category 5'),
                            ),
                            // Add more tabs as needed
                          ],
                        ),
                      ),
                    ),
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


 */

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../common/widgets/appbar/appbar.dart';
// import '../../../../../utils/constants/colors.dart';
// import 'controller/activity_controller.dart';
//
// // Sample JSON data for menus and contents
// const jsonData = '''
// [
//   {
//     "menuTitle": "First menu",
//     "contentColor": "cyan.shade50",
//     "contentText": "First Contents"
//   },
//   {
//     "menuTitle": "Second menu",
//     "contentColor": "red.shade50",
//     "contentText": "Second Contents"
//   },
//   {
//     "menuTitle": "Third menu",
//     "contentColor": "pink.shade50",
//     "contentText": "Third Contents"
//   }
// ]
// ''';
//
// class Activity extends StatelessWidget {
//   final ActivityController _controller = Get.put(ActivityController());
//
//   @override
//   Widget build(BuildContext context) {
//     final List<dynamic> menuData = json.decode(jsonData);
//
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: Colors.transparent,
//         showBackArrow: true,
//         centerTitle: false,
//         title: Text('Activities'),
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Obx(() {
//                 return Column(
//                   children: List.generate(menuData.length, (index) {
//                     final Map<String, dynamic> item = menuData[index];
//                     return _controller.selectedIndex.value == index
//                         ? Container(
//                       color: Colors
//                           .cyan
//                           .shade50, // Use the color from JSON data
//                       child: Text(item['contentText'] as String),
//                     )
//                         : SizedBox.shrink();
//                   }),
//                 );
//               }),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children:
//               List.generate(menuData.length, (index) {
//                 final Map<String, dynamic> item = menuData[index];
//                 return GestureDetector(
//                   onTap: () {
//                     _controller.setSelectedIndex(index);
//                   },
//                   child: Obx(() => Row(
//                     children: [
//                       RotatedBox(
//                         quarterTurns: 1,
//                         child: Container(
//                           color: _controller.selectedIndex.value == index
//                               ? Colors.white
//                               : Colors.transparent,
//                           child: Text(item['menuTitle'] as String),
//                         ),
//                       ),
//                     ],
//                   )),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import 'controller/activity_controller.dart';


class Activity extends StatelessWidget {
  final ActivityController _controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: false,
        title: Text('Activities'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() {
                  return Column(
                    children: [
                      if (_controller.selectedIndex.value == 0)
                        Container(
                          color: Colors.cyan.shade50,
                          child: const Text('First Contents'),
                        ),
                      if (_controller.selectedIndex.value == 1)
                        Container(
                          color: Colors.red.shade50,
                          child: const Text('Second Contents'),
                        ),
                      if (_controller.selectedIndex.value == 2)
                        Container(
                          color: Colors.pink.shade50,
                          child: const Text('Third Contents'),
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),

          /// Vertical Menu Containers
          SingleChildScrollView(
            child: Column(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.setSelectedIndex(0);
                          },
                          child: Obx(() => Container(
                            color: _controller.selectedIndex.value == 0
                                ? Colors.white
                                : Colors.transparent,
                            child: const Text('First menu'),
                          )),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            _controller.setSelectedIndex(1);
                          },
                          child: Obx(() => Container(
                            color: _controller.selectedIndex.value == 1
                                ? Colors.white
                                : Colors.transparent,
                            child: const Text('Second menu'),
                          )),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            _controller.setSelectedIndex(2);
                          },
                          child: Obx(() => Container(
                            color: _controller.selectedIndex.value == 2
                                ? Colors.white
                                : Colors.transparent,
                            child: const Text('Third menu'),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


 */

/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: false,
        title: Text(
          'Activities',
          style: TextStyleClass.appBarTextStyle
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: TabBarView(
                      children: [
                        // Content for Category 1
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                             // StackContainer(),
                             //  ContainerStack(),
                              SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  color: Colors.red.shade50,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  color: Colors.blue.shade50,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  color: Colors.red.shade50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Content for Category 2
                        Stack(
                         children: [
                           Container(
                             child: const Center(
                               child: Text('Category 2 content'),
                             ),
                           ),
                         ],
                        ),
                        // Content for Category 3
                        Container(
                          child: const Center(
                            child: Text('Category 3 content'),
                          ),
                        ),
                        // Add more TabBarView children as needed
                        Container(
                          child: const Center(
                            child: Text('Category 4 content'),
                          ),
                        ),
                        // Add more TabBarView children as needed
                        Container(
                          child: const Center(
                            child: Text('Category 5 content'),
                          ),
                        ),
                        // Add more TabBarView children as needed
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: const BoxConstraints.expand(
                            height: 50, width: double.maxFinite),
                        child: const TabBar(
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicator: DotTabIndicator(
                            color: Colors.redAccent,
                            radius: 4,
                          ),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Global Youth Fest 2023'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Global College Yoga Day'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Engineering'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Tab(text: 'Category 4'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Tab(text: 'Category 5'),
                            ),
                            // Add more tabs as needed
                          ],
                        ),
                      ),
                    ),
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

class DotTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const DotTabIndicator({required this.color, required this.radius});

  @override
  _DotPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(this, onChanged);
  }
}

class _DotPainter extends BoxPainter {
  final DotTabIndicator decoration;

  _DotPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()..color = decoration.color;
    final Rect rect = offset & configuration.size!;
    final double centerX = rect.center.dx;
    final double bottom = rect.bottom - 6; // Adjust the value based on your preference

    canvas.drawCircle(Offset(centerX, bottom), decoration.radius, paint);
  }
}

class ContainerStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Change this according to your requirement
      height: 200, // Change this according to your requirement
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100, // Change this according to your requirement
                  height: 100, // Change this according to your requirement
                  color: Colors.green,
                ),
                Container(
                  width: 100, // Change this according to your requirement
                  height: 100, // Change this according to your requirement
                  color: Colors.red,
                ),
                Container(
                  width: 100, // Change this according to your requirement
                  height: 100, // Change this according to your requirement
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 */

// import 'package:flutter/material.dart';
// import '../../../../../common/widgets/appbar/appbar.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
//
// class Activity extends StatelessWidget {
//   const Activity({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: GAppBar(
//         backgroundColor: Colors.transparent,
//         showBackArrow: true,
//         title: Text(
//           'Activities',
//           style: TextStyle(
//             fontSize: ESizes.appTitle,
//             fontFamily: 'Inter',
//             color: EColors.primary,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//
//
//         ],
//       ),
//     );
//   }
// }
//

/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/activity/widget/dot_indicator.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import 'model/model.dart';

class Activity extends StatelessWidget {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: EColors.backgroundColor,
      backgroundColor: EColors.black,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Activities',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              _currentPage.value = page;
            },
            scrollDirection: Axis.vertical, // Set scroll direction to vertical
            children: eventData.map((event) {
              return _buildEventCard(context, event);
            }).toList(),
          ),
          DotIndicator(pageCount: eventData.length, currentPage: _currentPage),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(event['image']),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(1.0),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 0.3, // Adjust this factor as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['type'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Venue: ${event['venue']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Date & Time: ${event['dateTime']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          _viewImageFullScreen(context, event['image']);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _viewImageFullScreen(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: const Icon(FontAwesomeIcons.doorClosed, color: Colors.white,)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: 'imageHero',
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

}
 */

/*

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import 'model/model.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text('Party Events'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: eventData.map((event) {
            return _buildEventCard(event);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(event['image']),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 0.3, // Adjust this factor as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['type'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Venue: ${event['venue']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Date & Time: ${event['dateTime']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
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


 */

// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/utils/constants/colors.dart';
// import '../../../../../common/widgets/appbar/appbar.dart';
//
// class Activity extends StatelessWidget {
//   const Activity({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: GAppBar(
//         backgroundColor: Colors.transparent,
//         showBackArrow: true,
//         title: Text('Activity'),
//       ),
//
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           children: [
//
//             ///
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
