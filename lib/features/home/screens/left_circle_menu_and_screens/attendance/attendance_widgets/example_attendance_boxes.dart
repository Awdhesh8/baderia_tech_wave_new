import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';

class ColorIndicationBoxExample extends StatelessWidget {
  const ColorIndicationBoxExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black12,
                      )
                    ]),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Present',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter'),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Colors.black12,
                      )
                    ]),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Absent',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter'),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Colors.black12,
                      )
                    ]),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Holiday',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter'),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Colors.black12,
                      )
                    ]),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Leave',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.yellow.shade300,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Colors.black12,
                      )
                    ]),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Weekend Holidays',
                style: TextStyle(fontSize: 12, fontFamily: 'Inter'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



