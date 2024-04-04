import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/teext_styles.dart';
import 'controller/form_controller.dart';
import 'package:shimmer/shimmer.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyleClass.appBarTextStyle
        ),
        centerTitle: false,
      ),
      body: VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final GlobalKey<_VTLetterContentState> _key =
  GlobalKey<_VTLetterContentState>();

  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 3));
        await controller.getCompany();
        await ApiService.fetchVtLetterHistory();
        setState(() {});
      },
      child: SingleChildScrollView(
        key: _key,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // const Text(
              //   'Ignite Your Journey with Vocational Excellence!',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 20),
              VTLetterForm(),
              const SizedBox(height: 20),
              const Divider(),
              FutureBuilder(
                future: ApiService.fetchVtLetterHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show shimmer loading while waiting for data
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: List.generate(5, (index) => _buildShimmerItem()),
                      ),
                    );
                  } else {
                    // Show VT letter history if data is available
                    return VtletterHistory();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}


/*
class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: const VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final GlobalKey<_VTLetterContentState> _key =
  GlobalKey<_VTLetterContentState>();
  final double _offsetToArmed = 100.0;

  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 3));
        await controller.getCompany();
        await ApiService.fetchVtLetterHistory();
        setState(() {});
      },
      offsetToArmed: _offsetToArmed,
      builder: (context, child, controller) => Stack(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) => SizedBox(
              width: double.infinity,
              height: _offsetToArmed * controller.value,
              child: const RiveAnimationWidget(),
            ),
          ),
          if (controller.isLoading)
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: RichText(
                  text: const TextSpan(
                    text: 'Loading...\n',
                    style: TextStyle(fontSize: 18),
                    children: [
                      TextSpan(text: '\nWant to play???'),
                      TextSpan(text: '\nthen'),
                      TextSpan(text: '\nHit on Para-shoot...'),
                    ],
                  ),
                ),
              ),
            )
          else
            child,
        ],
      ),
      child: SingleChildScrollView(
        key: _key,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                'Ignite Your Journey with Vocational Excellence!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              VTLetterForm(),
              const SizedBox(height: 20),
              const Divider(),
              Container(
                color: Colors.white,
                child: VtletterHistory(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */

/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:rive/rive.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/refresh_puller/refresh_puller.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'controller/form_controller.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: const VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final GlobalKey<_VTLetterContentState> _key =
  GlobalKey<_VTLetterContentState>();
  final double _offsetToArmed = 100.0; // Adjust as per your requirement

  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Simulate data fetching delay
        await Future.delayed(const Duration(seconds: 3));

        // Fetch data again
        await controller.getCompany();
        await ApiService.fetchVtLetterHistory();

        setState(() {}); // Reload screen
      },
      offsetToArmed: _offsetToArmed,
      builder: (context, child, controller) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: double.infinity,
                    height: _offsetToArmed * controller.value,
                    child: const RiveAnimationWidget(),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  0.0,
                  _offsetToArmed * controller.value,
                ),
                child: controller.isLoading
                    ? Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Loading...\n',
                        style: TextStyleClass.heading28,
                        children: [
                          TextSpan(
                            text: '\nWant to play???',
                            style: TextStyleClass.bodyText2,
                          ),
                          TextSpan(
                            text: '\nthen',
                            style: TextStyleClass.bodyText2,
                          ),
                          TextSpan(
                            text: '\nHit on Para-shoot...',
                            style: TextStyleClass.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : child,
              ),
            ],
          );
        },
        child: child,
      ),
      child: SingleChildScrollView(
        key: _key,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */

/*
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../data/api/api_services.dart';
import 'controller/form_controller.dart';
class VTLetter extends StatelessWidget {
   VTLetter({Key? key});

  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: darkMode ? Colors.black : Colors.white,
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          // Fetch APIs again here
          // Example: controller.fetchData()
          await controller.getCompany();
          await ApiService.fetchVtLetterHistory();
          return Future.value();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Ignite Your Journey',
                        style: TextStyleClass.heading24,
                        children: [
                          TextSpan(text: ' with '),
                          TextSpan(
                            text: '\nVocational Excellence!',
                            style: TextStyleClass.heading22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                VTLetterForm(),
                const SizedBox(height: 20),
                const Divider(),

                SingleChildScrollView(
                  child: Container(
                    child: VtletterHistory(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


 */


/// Correct and proper code for the Rive animation trigger when pull to refresh
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:rive/rive.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/refresh_puller/refresh_puller.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'controller/form_controller.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: const VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final GlobalKey<_VTLetterContentState> _key =
  GlobalKey<_VTLetterContentState>();
  final double _offsetToArmed = 100.0; // Adjust as per your requirement

  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Simulate data fetching delay
        await Future.delayed(const Duration(seconds: 3));

        // Fetch data again
        await controller.getCompany();
        await ApiService.fetchVtLetterHistory();

        setState(() {}); // Reload screen
      },
      offsetToArmed: _offsetToArmed,
      builder: (context, child, controller) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: double.infinity,
                    height: _offsetToArmed * controller.value,
                    child: RiveAnimationWidget(),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  0.0,
                  _offsetToArmed * controller.value,
                ),
                child: controller.isLoading
                    ? Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Loading...\n',
                        style: TextStyleClass.heading28,
                        children: [
                          TextSpan(
                            text: '\nWant to play???',
                            style: TextStyleClass.bodyText2,
                          ),
                          TextSpan(
                            text: '\nthen',
                            style: TextStyleClass.bodyText2,
                          ),
                          TextSpan(
                            text: '\nHit on Para-shoot...',
                            style: TextStyleClass.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : child,
              ),
            ],
          );
        },
        child: child,
      ),
      child: SingleChildScrollView(
        key: _key,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */



/// in this code rive and animation both are doing propely
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:rive/rive.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'controller/form_controller.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: const VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final GlobalKey<_VTLetterContentState> _key =
      GlobalKey<_VTLetterContentState>();
  final double _offsetToArmed = 100.0; // Adjust as per your requirement
  late RiveAnimationController _riveController;

  final controller = Get.put(VTLetterFormController());

  @override
  void initState() {
    super.initState();
    _riveController = SimpleAnimation("idle");
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        // Trigger Rive animation state machine
        _riveController.isActive = true;

        // Simulate data fetching delay
        await Future.delayed(const Duration(seconds: 2));

        // Fetch data again
        await controller.getCompany();
        await ApiService.fetchVtLetterHistory();

      },
      offsetToArmed: _offsetToArmed,
      builder: (context, child, controller) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: double.infinity,
                    height: _offsetToArmed * controller.value,
                    // height: _offsetToArmed * controller.value,
                    child: RiveAnimation.asset(
                      "assets/RiveAssets/help! (2).riv",
                      fit: BoxFit.cover,
                      animations: const ['Motion'],
                      stateMachines: const ['Motion'],
                      controllers: [_riveController],
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  0.0,
                  _offsetToArmed * controller.value,
                ),
                child: controller.isLoading
                    ? Center(
                        child: SizedBox(
                        width: 300,
                        height: 300,
                        child: RichText(
                          text: const TextSpan(
                            text: 'Loading...\n',
                            style: TextStyleClass.heading28,
                            children: [
                              TextSpan(
                                text: '\nWant to play???',
                                style: TextStyleClass.bodyText2,
                              ),
                              TextSpan(
                                text: '\nthen',
                                style: TextStyleClass.bodyText2,
                              ),
                              TextSpan(
                                text: '\nHit on Para-shoot...',
                                style: TextStyleClass.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ))
                    : child,
              ),
            ],
          );
        },
        child: child,
      ),
      child: SingleChildScrollView(
        key: _key,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



 */



/// rive asset is woring fine but the asset is not animating
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:rive/rive.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'controller/form_controller.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatelessWidget {
  final double _offsetToArmed = 220.0; // Adjust as per your requirement

  final controller = Get.put(VTLetterFormController());


  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () => Future.delayed(const Duration(seconds: 2)),
      offsetToArmed: _offsetToArmed,
      builder: (context, child, controller) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: _offsetToArmed * controller.value,
                child: const RiveAnimation.asset(
                  "assets/RiveAssets/help! (4).riv",
                  fit: BoxFit.cover,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  0.0,
                  _offsetToArmed * controller.value,
                ),
                child: controller.isLoading ? Container(color: Colors.black54, width: 300, height: 300,) : child,
              ),
            ],
          );
        },
        child: child,
      ), child:  SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Ignite Your Journey',
                    style: TextStyleClass.heading24,
                    children: [
                      TextSpan(text: ' with '),
                      TextSpan(
                        text: '\nVocational Excellence!',
                        style: TextStyleClass.heading22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: ESizes.spaceBtwSections),
            VTLetterForm(),
            const SizedBox(height: ESizes.spaceBtwSections),
            const Divider(),
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: EColors.backgroundColor,
                ),
                child: VtletterHistory(),
              ),
            ),
          ],
        ),
      ),
    ),
      //child: SizedBox(),
    );
  }
}


 */

/// Refresh puller is working to refresh the screen
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'controller/form_controller.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: const VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final controller = Get.put(VTLetterFormController());

  Future<void> _handleRefresh() async {
    // Simulate data fetching delay
    await Future.delayed(const Duration(seconds: 2));

    // Trigger UI update
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/



/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import 'controller/form_controller.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: VTLetterContent(),
    );
  }
}

class VTLetterContent extends StatefulWidget {
  const VTLetterContent({Key? key}) : super(key: key);

  @override
  _VTLetterContentState createState() => _VTLetterContentState();
}

class _VTLetterContentState extends State<VTLetterContent> {
  final controller = VTLetterFormController(); // Assuming this is your form controller

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Await the API responses
        await Future.wait([
          controller.getCompany(),
          ApiService.fetchVtLetterHistory(),

        ]);
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/// correct code extra
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return RefreshIndicator(
      onRefresh: () => Future.delayed(const Duration(seconds: 1)),
      child: Scaffold(
        backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,

        /// App Bar
        appBar: const GAppBar(
          backgroundColor: Colors.transparent,
          showBackArrow: true,
          title: Text(
            'Vocational Training',
            style: TextStyle(
              fontSize: ESizes.appTitle,
              fontFamily: 'Inter',
              color: EColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: false,
        ),

        /// Body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                /// Top heading
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Ignite Your Journey',
                        style: TextStyleClass.heading24,
                        children: [
                          TextSpan(text: ' with '),
                          TextSpan(
                            text: '\nVocational Excellence!',
                            style: TextStyleClass.heading22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: ESizes.spaceBtwSections),

                /// VT Letter Form
                VTLetterForm(),
                const SizedBox(height: ESizes.spaceBtwSections),
                const Divider(),

                /// history heading
                /*Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Check History Status',
                        style: TextStyleClass.inputText1,
                        children: [
                          TextSpan(text: ' for '),
                          TextSpan(
                            text: '\nVT Application',
                            style: TextStyleClass.heading22,
                          ),
                        ],
                      ),
                    ),


                  ],
                ),

                 */

                SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: EColors.backgroundColor,
                    ),
                    child: VtletterHistory(),
                  ),
                ),

                ///
                // MyApp()
              ],
            ),
          ),
        ),

      ),
    );
  }
}


 */

/// Correct code
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,

      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),

      /// Body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              /// Top heading
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: ESizes.spaceBtwSections),

              /// VT Letter Form
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),

              /// history heading
              /*Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Check History Status',
                      style: TextStyleClass.inputText1,
                      children: [
                        TextSpan(text: ' for '),
                        TextSpan(
                          text: '\nVT Application',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),


                ],
              ),

               */

              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),

              ///
              // MyApp()
            ],
          ),
        ),
      ),
    );
  }
}

*/

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Initialize your controller
//     final ToggleController controller = Get.put(ToggleController());
//
//     return
//
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Obx widget listens to changes in the toggle state
//             Obx(
//                   () => controller.isContainerVisible.value
//                   ? Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container is visible!',
//                     style: TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                 ),
//               )
//                   : Container(), // Empty container when not visible
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Toggle the container visibility
//                 controller.toggleContainerVisibility();
//               },
//               child: Text('Toggle Container'),
//             ),
//           ],
//         )
//
//     ;
//   }
// }
//
// // Define a controller class extending GetxController
// class ToggleController extends GetxController {
//   // Define the state variable for toggle
//   var isContainerVisible = false.obs;
//
//   // Method to toggle the container visibility
//   void toggleContainerVisibility() {
//     isContainerVisible.value = !isContainerVisible.value;
//   }
//
// }
