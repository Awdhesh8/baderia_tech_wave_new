import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../bottom_navigation_menu/navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../password_configuration/forget_password.dart';

class ELoginForm extends StatelessWidget {
  const ELoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtwSections),
        child: Column(
          children: [
            // Email --->
            TextFormField(
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right,), labelText: ETexts.email),
            ),
            const SizedBox(height: ESizes.spaceBtwInputField,),
            TextFormField(
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check,), labelText: ETexts.password, suffixIcon: Icon(Iconsax.eye_slash),),
            ),
            const SizedBox(height: ESizes.spaceBtwInputField / 2,),


            // Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value){},),
                    const Text(ETexts.rememberMe),
                  ],
                ),

                // Forget Password
                TextButton(onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(ETexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: ESizes.spaceBtwSections,),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: dark ?  Colors.black : EColors.primary,
                  side: BorderSide.none,
                ),
                onPressed: () => Get.to(() => const NavigationMenu()) ,
                child: const Text(ETexts.loginIn),
              ),
            ),

            const SizedBox(height: ESizes.spaceBtwItems,),

            /*
            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () {},
              // => Get.to(() => const SignupScreen()) ,
                child: const Text(ETexts.createAccount),
              ),
            ),

            */
          ],
        ),
      ),
    );
  }
}
