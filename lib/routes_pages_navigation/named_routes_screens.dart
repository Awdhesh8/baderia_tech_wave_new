import 'package:get/get.dart';
import '../features/authentication/screens/splash_screen/splash_screen.dart';
import '../features/home/screens/default_screen/default_screen.dart';
import '../features/home/screens/left_circle_menu_and_screens/fees/fees_screen.dart';
import '../features/home/screens/left_circle_menu_and_screens/library/library_screen.dart';
import '../features/home/screens/right_circle_menu_and_screens/assessment_test/assessment_test_screen.dart';
import '../features/home/screens/right_circle_menu_and_screens/cv_resume/cv_resume_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String fees = '/Fees';
  static const String library = '/Library';
  static const String defaultScreen = '/DefaultScreen';
  static const String cvResume = '/CVResumeScreen';
  static const String assessment = '/AssessmentTestScreen';


  static List<GetPage> routes = [
    GetPage(name: defaultScreen, page: () => const DefaultScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    
    /// These are sub screens
    GetPage(name: fees, page: () => FeesScreen()),
    GetPage(name: library, page: () =>  LibraryScreen()),
    GetPage(name: cvResume, page: () => const CVResumeScreen()),
    GetPage(name: assessment, page: () => const AssessmentTestScreen()),

  ];
}
