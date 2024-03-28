import 'package:flutter/material.dart';
import '../../../../common/styles/spacing_styles.dart';
import 'login_widgets/login_form.dart';
import 'login_widgets/login_header.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
     // final dark = EHelperFunctions.isDarkMode(context);

    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: ESpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // HEADER ---> Logo, title & subtitle
             ELoginHeader(),

              //  <--- Form --->
              ELoginForm(),

              /*
              // Divider
              EFormDivider(dividerText: ETexts.orSignInWith.capitalize!,),
              const SizedBox(height: ESizes.spaceBtwSections,),

              // Footer
              const ESocialButtons(),
              */

            ],
          ),
        ),
      ),
    );
  }
}







