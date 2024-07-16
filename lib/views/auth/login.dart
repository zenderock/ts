import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_vision/components/bottom_navigation.dart';
import 'package:the_vision/controllers/login_controller.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  var isLogin = false;

  bool _obscureText = true;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(
              top: TVSizes.defaultSpace,
              bottom: TVSizes.defaultSpace,
              left: TVSizes.defaultSpace,
              right: TVSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: TVSizes.spaceBetweenSections * 2),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Image(
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          TVImagesString.appLogo,
                        )),
                    const SizedBox(height: TVSizes.spaceBtwInput),
                    Text("Connexion",
                        style: TextStyle(
                            fontSize: TVSizes.fontLg * 1.5,
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold)),
                    Text("Accédez à votre compte THE VISION",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: TVSizes.spaceBetweenSections * 1.5),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: loginController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? "Veuillez entrer votre email" : null,
                      decoration: const InputDecoration(
                          labelText: "Votre email",
                          prefixIcon: Icon(Iconsax.direct_right),
                          hintText: "Entrer votre email",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: TVSizes.spaceBtwInput),
                    TextFormField(
                      controller: loginController.passwordController,
                      validator: (value) => value!.isEmpty || value.length < 6
                          ? "Veuillez entrer votre mot de passe"
                          : null,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        hintText: "Entrer votre mot de passe",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: GestureDetector(
                          onTap: _toggleObscureText,
                          child: Icon(
                              _obscureText ? Iconsax.eye : Iconsax.eye_slash),
                        ),
                      ),
                    ),
                    const SizedBox(height: TVSizes.spaceBetweenSections),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Checkbox(value: true, onChanged: (value) {}),
                    //         const Text("Se rapeller de moi")
                    //       ],
                    //     ),
                    //     TextButton(
                    //         onPressed: () {},
                    //         child: const Text("Mot de passe oublié?"))
                    //   ],
                    // ),
                    const SizedBox(height: TVSizes.spaceBetweenSections),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade900,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () => {
                          showDialog(
                              context: context,
                              builder: ((context) => const AlertDialog(
                                      content: Row(
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(width: TVSizes.spaceBtwInput),
                                      Text("Connexion en cours..."),
                                    ],
                                  )))),
                          loginController.loginWithEmail().then((value) => {
                                if (value)
                                  {
                                    Get.offAll(
                                      () => const BottomNavigation(),
                                    ),
                                  }
                                else
                                  {
                                    Navigator.of(context).pop(),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Erreur de connexion: Les informations saisies ne sont pas valides."),
                                      ),
                                    ),
                                  }
                              }),
                        },
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
