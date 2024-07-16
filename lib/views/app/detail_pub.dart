import 'package:flutter/material.dart';
import 'package:the_vision/utils/constants/sizes.dart';

class DetailPubScreen extends StatelessWidget {
  const DetailPubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Programme d'échange d'été susi 2024"),
        elevation: 1,
        backgroundColor: Colors.blue.shade100,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/ban1.png")),
            SizedBox(height: TVSizes.spaceBetweenSections),
            Text(
              "Programme d'echange d'été susi 2024",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: TVSizes.spaceBetweenSections),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Le programme d'échange d'été susi 2024 est un programme de réflexion et de découverte qui vise à promouvoir la coopération et la solidarité entre les écoles et les partenaires de l'école de la région de la Haute-Savoie.",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
