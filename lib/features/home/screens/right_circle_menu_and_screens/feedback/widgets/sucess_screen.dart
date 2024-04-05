import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final Function() onGoBack;

  SuccessScreen({required this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Feedback Submitted Successfully!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onGoBack(); // Call the callback function
                Navigator.pop(context); // Pop back to previous screen
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

