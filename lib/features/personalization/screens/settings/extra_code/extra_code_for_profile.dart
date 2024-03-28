
/*
            // --- Header ---
            EPrimaryHeaderContainer(child: Column(
              children: [
                GAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: EColors.white),),),
                const SizedBox(height: ESizes.spaceBtwItems,),

                // User Profile Card
                EUserProfileTile(onPressed: () => Get.to(() => const PersonalInformationScreen())),
                const SizedBox(height: ESizes.spaceBtwSections,),
              ],
            ),
            ),

            // Body ---
            Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [

                  // --- Account Settings ---
                  const ESectionHeading(title: 'Account Settings', showActionButton: false,),
                  const SizedBox(height: ESizes.spaceBtwItems,),

                  ESettingsMenuTile(icon: Iconsax.information, title: 'Personal Information', subTitle: 'Click to view your info', onTap: () => Get.to(() => const PersonalInformationScreen()),),  // const UserAddressScreen()
                  ESettingsMenuTile(icon: Iconsax.info_circle, title: 'Educational Information', subTitle: 'Click to view your info', onTap: () {},),
                  // ESettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress and Completed Orders', onTap: () {}), // Get.to(() => const OrderScreen())
                  // ESettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTap: () {},),
                  // ESettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons', onTap: () {},),
                  ESettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set and kind of notification message', onTap: () {},),
                  ESettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected account', onTap: () {},),

                  // -- App Settings ---
                  const SizedBox(height: ESizes.spaceBtwSections,),
                  const ESectionHeading(title: 'App Settings', showActionButton: false,),
                  const SizedBox(height: ESizes.spaceBtwItems,),
                  const ESettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase'),

                  // Switch's --
                  ESettingsMenuTile(icon: Iconsax.location, title: 'Geolocation', subTitle: 'Set recommendation based on location',trailing: Switch(value: true, onChanged: (value){},),),
                  ESettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Search result is safe for all ages',trailing: Switch(value: false, onChanged: (value){},),),
                  ESettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set image quality to be seen',trailing: Switch(value: false, onChanged: (value){},),),


                  // --- Logout Button ---
                  const SizedBox(height: ESizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){},child: const Text('Logout'),),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections * 2.5,),
                ],
              ),
            ),

             */