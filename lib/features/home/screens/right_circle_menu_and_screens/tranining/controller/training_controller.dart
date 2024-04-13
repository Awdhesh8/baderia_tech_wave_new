import 'package:get/get.dart';

class TrainingController extends GetxController {
  final trainingData = {}.obs;
  final isLoading = true.obs; // Define isLoading variable

  @override
  void onInit() {
    fetchTrainingData();
    super.onInit();
  }

  void fetchTrainingData() async {
    isLoading.value = true; // Set isLoading to true when fetching data
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy JSON data
    var data = {
      "response": {
        "current_training": [
          {
            "training_name": "Vocational Training",
            "from_date": "10/04/2024",
            "to_date": "20/04/2024",
            "timing": "11:35 AM - 11:15 AM",
            "status": "13 Days Left 13 & Hours Left: 130",
            "trainer": "Jhon Wick",
            "assignment": [
              {
                "title": "Assignment 1",
                "assign_date": "10/04/2024",
                "last_date": "15/04/2024",
                "description": "Complete the assigned tasks",
                "links": ["https://example.com/assignment1"],
                "attachments": [
                  {"name": "Assignment.pdf", "link": "https://example.com/assignment1.pdf"}
                ]
              },
              // Add more assignments as needed
            ],
            "study_material": [
              {
                "title": "Study Material 1",
                "description": "Read chapters 1-3 for upcoming session",
                "links": ["https://example.com/studymaterial1"],
                "attachments": [
                  {"name": "Chapter 1.pdf", "link": "https://example.com/chapter1.pdf"}
                ]
              },
              // Add more study materials as needed
            ]
          },
          {
            "training_name": "AI Training",
            "from_date": "12/04/2024",
            "to_date": "20/04/2024",
            "timing": "01:35 PM - 03:15 PM",
            "status": "11 Days Left 13 & Hours Left: 130",
            "trainer": "Jack jack",
            "assignment": [
              {
                "title": "Assignment 1",
                "assign_date": "12/04/2024",
                "last_date": "18/04/2024",
                "description": "Complete the AI project",
                "links": ["https://example.com/aiassignment1"],
                "attachments": [
                  {"name": "Project Proposal.docx", "link": "https://example.com/projectproposal.docx"}
                ]
              },
              // Add more assignments as needed
            ],
            "study_material": [
              {
                "title": "Study Material 1",
                "description": "Read chapters 4-6 for upcoming session",
                "links": ["https://example.com/studymaterial2"],
                "attachments": [
                  {"name": "Chapter 4.pdf", "link": "https://example.com/chapter4.pdf"}
                ]
              },
              // Add more study materials as needed
            ]
          }
        ],
        "completed_trainings": [
          {
            "training_name": "Vocational Training [ I ]",
            "from_date": "10/04/2024",
            "to_date": "20/04/2024",
            "timing": "11:35 AM - 11:15 AM",
            "status": "completed",
            "trainer": "Jhon Wick"
          },
          {
            "training_name": "ML Training",
            "from_date": "12/04/2024",
            "to_date": "20/04/2024",
            "timing": "01:35 PM - 03:15 PM",
            "status": "Completed",
            "trainer": "Jack jack"
          }
        ]
      }
    };


    trainingData.value = data;
    isLoading.value = false; // Set isLoading to false after data is fetched
  }
}


/*
var data = {
      "response": {
        "current_training": [
          {
            "training_name": "Vocational Training",
            "from_date": "10/04/2024",
            "to_date": "20/04/2024",
            "timing": "11:35 AM - 11:15 AM",
            "status": "13 Days Left 13 & Hours Left: 130",
            "trainer": "Jhon Wick",
          },
          {
            "training_name": "AI Training",
            "from_date": "12/04/2024",
            "to_date": "20/04/2024",
            "timing": "01:35 PM - 03:15 PM",
            "status": "11 Days Left 13 & Hours Left: 130",
            "trainer": "Jack jack"
          }
        ],
        "completed_trainings": [
          {
            "training_name": "Vocational Training [ I ]",
            "from_date": "10/04/2024",
            "to_date": "20/04/2024",
            "timing": "11:35 AM - 11:15 AM",
            "status": "completed",
            "trainer": "Jhon Wick"
          },
          {
            "training_name": "ML Training",
            "from_date": "12/04/2024",
            "to_date": "20/04/2024",
            "timing": "01:35 PM - 03:15 PM",
            "status": "Completed",
            "trainer": "Jack jack"
          }
        ]
      }
    };

 */