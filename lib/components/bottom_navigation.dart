import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_vision/controllers/bottom_navigation_controller.dart';
import 'package:the_vision/views/app/scan_qrcode.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> checkIsClient() async {
    final SharedPreferences prefs = await _prefs;
    final String role = prefs.getString("role") ?? "";

    return role != "CLIENT";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {}
          Get.to(() => const BottomNavigation());
        },
        child: Scaffold(
            bottomNavigationBar: Obx(
              () => NavigationBar(
                height: 80.0,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (value) => {
                  controller.selectedIndex.value = value,
                  if (value == 0) controller.isVisible.value = true,
                  if (value > 0) controller.isVisible.value = false,
                },
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Iconsax.home), label: 'Accueil'),
                  NavigationDestination(
                      icon: Icon(Iconsax.task), label: 'Dossiers'),
                  NavigationDestination(
                      icon: Icon(Iconsax.notification), label: 'Notifications'),
                  NavigationDestination(
                      icon: Icon(Iconsax.user), label: 'Profile'),
                ],
              ),
            ),
            body: Obx(
              () => controller.screens[controller.selectedIndex.value],
            ),
            floatingActionButton: FutureBuilder<bool>(
              future: checkIsClient(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return FloatingActionButton(
                      onPressed: () {
                        Get.to(() => const ScanQrcodeScreen());
                      },
                      child: const Icon(Iconsax.scan),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            )));
  }
}
