import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawrentingreborn/features/community/screens/community.dart';
import 'package:pawrentingreborn/features/home/screens/home.dart';
import 'package:pawrentingreborn/features/mypets/screens/petlist/petlist.dart';
import 'package:pawrentingreborn/features/profile/screens/profile.dart';
import 'package:pawrentingreborn/utils/constants/colors.dart';
import 'package:pawrentingreborn/utils/constants/images_strings.dart';

import 'features/home/translatePet/translatePet.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.find();
    return Scaffold(
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const TranslatePet());
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              width: 100,
              height: 100,
              decoration: const BoxDecoration(color: TColors.accent),
              child: const ImageIcon(
                AssetImage(TImages.translateIcon),
                size: 72,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () => NavigationBar(
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              backgroundColor: Colors.white,
              height: 80,
              destinations: const [
                NavigationDestination(
                    icon: ImageIcon(
                      AssetImage(TImages.homeIcon),
                      color: TColors.accent,
                      size: 28,
                    ),
                    label: 'Home'),
                NavigationDestination(
                    icon: ImageIcon(AssetImage(TImages.myPetIcon),
                        color: TColors.accent, size: 28),
                    label: 'My Pets'),
                SizedBox(
                  width: 100,
                ),
                NavigationDestination(
                    icon: ImageIcon(AssetImage(TImages.communityIcon),
                        color: TColors.accent, size: 28),
                    label: 'Community'),
                NavigationDestination(
                    icon: ImageIcon(AssetImage(TImages.profileIcon),
                        color: TColors.accent, size: 28),
                    label: 'Profile'),
              ]),
        ),
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const Home(),
    const PetList(),
    Container(
      color: Colors.yellow,
    ),
    const Community(),
    Profile(),
  ];
  @override
  void onClose() {
    print('monyet');
    selectedIndex.value = 0;
    super.onClose();
  }
}
