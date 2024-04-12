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
            "trainer": "Jhon Wick"
          },
          {
            "training_name": "Vocational Training",
            "from_date": "12/04/2024",
            "to_date": "20/04/2024",
            "timing": "01:35 PM - 03:15 PM",
            "status": "11 Days Left 13 & Hours Left: 130",
            "trainer": "Jack jack"
          }
        ],
        "completed_trainings": [
          {
            "training_name": "Vocational Training",
            "from_date": "10/04/2024",
            "to_date": "20/04/2024",
            "timing": "11:35 AM - 11:15 AM",
            "status": "completed",
            "trainer": "Jhon Wick"
          },
          {
            "training_name": "Vocational Training",
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
