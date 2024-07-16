import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/utils/constants/sizes.dart';
import 'package:the_vision/views/auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getName() async {
    final SharedPreferences prefs = await _prefs;
    final String firstname = prefs.getString("firstname") ?? "";

    return firstname;
  }

  Future<String> getLastName() async {
    final SharedPreferences prefs = await _prefs;
    final String lastname = prefs.getString("lastname") ?? "";

    return lastname;
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await _prefs;
    final String email = prefs.getString("email") ?? "";

    return email;
  }

  Future<String> getAvatar() async {
    final SharedPreferences prefs = await _prefs;
    final String avatar = prefs.getString("avatar") ?? "";

    return avatar;
  }

  Future<void> logoutUser() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("token", "");
    await prefs.setString("firstname", "");
    await prefs.setString("lastname", "");
    await prefs.setString("phone", "");
    await prefs.setString("email", "");
    await prefs.setString("role", "");
    await prefs.setString("avatar", "");
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.red.shade200,
              ),
            ],
          ),
          Positioned(
            top: 120,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<String>(
                  future: getAvatar(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          boxShadow: List.generate(
                            4,
                            (index) => BoxShadow(
                                color: Colors.black12,
                                offset: Offset(index * 2, index * 2),
                                blurRadius: index * 2),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!),
                          radius: 80,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircleAvatar(
                          child: Image(
                              image: AssetImage(TVImagesString.appLogo),
                              height: 200,
                              width: 200),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: TVSizes.defaultSpace),
                FutureBuilder<String>(
                  future: getName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      return Wrap(
                        children: [
                          Text("${snapshot.data}",
                              style: const TextStyle(fontSize: TVSizes.fontLg)),
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text("Une erreur est survenue"));
                    }
                  },
                ),
                FutureBuilder<String>(
                  future: getLastName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      return Wrap(
                        children: [
                          Text("${snapshot.data}",
                              style: const TextStyle(fontSize: TVSizes.fontLg)),
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text("Une erreur est survenue"));
                    }
                  },
                ),
                FutureBuilder<String>(
                  future: getEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      return Text("${snapshot.data}",
                          style: const TextStyle(fontSize: 15));
                    } else {
                      return const Center(
                          child: Text("Une erreur est survenue"));
                    }
                  },
                ),
                const SizedBox(height: TVSizes.spaceBetweenSections),
                ElevatedButton(
                  onPressed: logoutUser,
                  child: const Text("Deconnexion"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
