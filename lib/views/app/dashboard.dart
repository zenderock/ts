import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_vision/components/header.dart';
import 'package:the_vision/components/search_folder.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/utils/constants/sizes.dart';
import 'package:the_vision/views/app/detail_pub.dart';
import 'package:the_vision/views/app/parthners.dart';
import 'package:the_vision/views/app/shools.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> checkIsClient() async {
    final SharedPreferences prefs = await _prefs;
    final String role = prefs.getString("role") ?? "";
    return role != "CLIENT";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 255, 227, 230),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: TVSizes.appbarHeight * 1.3,
                  left: TVSizes.defaultSpace,
                  right: TVSizes.defaultSpace,
                  bottom: TVSizes.defaultSpace,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Image(
                              height: 40,
                              width: 40,
                              image: AssetImage(TVImagesString.appLogo),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'THE VISION',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade900),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Iconsax.user3))
                      ],
                    ),
                    const SizedBox(
                      height: TVSizes.defaultSpace,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Header(),
                          const Text("Gerez vos dossiers en toute simplicité."),
                          const SizedBox(
                            height: 10.0,
                          ),
                          FutureBuilder<bool>(
                            future: checkIsClient(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!) {
                                  return const SearchFolder();
                                } else {
                                  return const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(),
                                      Text("Information",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "Vous pouvez cliquer sur le menu dossier pour accéder à vos dossiers"),
                                    ],
                                  );
                                }
                              } else {
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(),
                                    Text("Information",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "Vous pouvez cliquer sur le menu dossier pour accéder à vos dossiers"),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(TVSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Actualités",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: TVSizes.spaceBetweenItems),
                    CarouselSlider(
                      options:
                          CarouselOptions(viewportFraction: 1, autoPlay: true),
                      items: const [
                        BannerContainer(
                            image: TVImagesString.ban1, url: "url1"),
                        BannerContainer(
                            image: TVImagesString.ban2, url: "url2"),
                        BannerContainer(
                            image: TVImagesString.ban3, url: "url3"),
                        BannerContainer(
                            image: TVImagesString.ban4, url: "url4"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(TVSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ShoolsScreen());
                    },
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(TVSizes.md)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(TVImagesString.ecole),
                            height: 50,
                            width: 50,
                          ),
                          Text("Nos Ecoles", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ParthnersScreen());
                    },
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(TVSizes.md)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(TVImagesString.pathners),
                            height: 60,
                            width: 60,
                          ),
                          Text("Nos partenaires",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BannerContainer extends StatelessWidget {
  const BannerContainer({
    super.key,
    required this.image,
    required this.url,
  });

  final String image, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const DetailPubScreen(), arguments: {"url": url});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TVSizes.md),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(TVSizes.md),
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
