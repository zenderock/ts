import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:the_vision/views/auth/login.dart";

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Variables

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(int page) {
    currentPageIndex.value = page;
  }

  void dotNavigationClicked(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() async {
    if (currentPageIndex.value == 2) {
      final SharedPreferences prefs = await _prefs;
      await prefs.setBool("hasSeenOnboarding", true);
      Get.offAll(() => const LoginScreen());
    }
    int page = currentPageIndex.value + 1;
    currentPageIndex.value = page;
    pageController.jumpToPage(page);
  }

  void skipPage() {
    Get.offAll(const LoginScreen());
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
