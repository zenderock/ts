import 'package:flutter/material.dart';
import 'package:the_vision/utils/constants/images_string.dart';

class SchoolDetailScreen extends StatefulWidget {
  const SchoolDetailScreen({super.key});

  @override
  _SchoolDetailScreenState createState() => _SchoolDetailScreenState();
}

class _SchoolDetailScreenState extends State<SchoolDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage(TVImagesString.ban1),
            ),
          ],
        ),
      ),
    );
  }
}
