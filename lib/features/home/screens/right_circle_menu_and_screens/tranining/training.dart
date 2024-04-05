import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SyllabusScreen extends StatelessWidget {
  final List<String> subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Computer Science',
    'English',
    // Add more subjects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syllabus'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigate to syllabus details screen for the selected subject
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SyllabusDetailsScreen(subject: subjects[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.bookOpen,
                      size: 48.0,
                      color: Colors.blue,
                    ),
                    Text(
                      subjects[index],
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Units: 10',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SyllabusDetailsScreen extends StatelessWidget {
  final String subject;

  SyllabusDetailsScreen({required this.subject});

  // Dummy syllabus content
  final String syllabusContent = """
  This is a dummy syllabus content for .
  You can replace it with the actual syllabus content.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              syllabusContent.replaceAll('subject', subject),
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
