import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_vision/controllers/onboarding_controller.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/utils/constants/sizes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              Padding(
                padding: EdgeInsets.all(TVSizes.defaultSpace),
                child: OnBoarding(
                    image: TVImagesString.onboardingImage1,
                    title: "Bienvenue sur The Vision",
                    subtitle:
                        "L'application mobile vous permettant de facilement suivre l'évolution de vos dossiers."),
              ),
              Padding(
                padding: EdgeInsets.all(TVSizes.defaultSpace),
                child: OnBoarding(
                    image: TVImagesString.onboardingImage2,
                    title: "Ajouter vos dossiers",
                    subtitle:
                        "Suivez vos dossiers et même celui de vos proches à partir de votre compte en entrant juste le code du dossier en scannant le code QR du dossier."),
              ),
              Padding(
                padding: EdgeInsets.all(TVSizes.defaultSpace),
                child: OnBoarding(
                    image: TVImagesString.onboardingImage3,
                    title: "C'est parti !",
                    subtitle: "Vos dossiers n'attendent que vous."),
              ),
            ],
          ),
          const OnboardingSkipBtn(),
          Positioned(
            bottom: 50,
            left: TVSizes.defaultSpace,
            child: SmoothPageIndicator(
              controller: controller.pageController,
              onDotClicked: controller.dotNavigationClicked,
              count: 3,
              effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.black, dotHeight: 8),
            ),
          ),
          Positioned(
              bottom: 25,
              right: TVSizes.defaultSpace,
              child: ElevatedButton(
                onPressed: () {
                  controller.nextPage();
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.red.shade900),
                child: const Icon(Iconsax.arrow_right_3, color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class OnboardingSkipBtn extends StatelessWidget {
  const OnboardingSkipBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Positioned(
        top: TVSizes.appbarHeight,
        child: TextButton(
          onPressed: () {
            controller.skipPage();
          },
          child: const Text("Passer"),
        ));
  }
}

class OnBoarding extends StatelessWidget {
  const OnBoarding({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: TVSizes.fontLg * 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TVSizes.spaceBetweenItems),
        Text(subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center),
      ],
    );
  }
}
