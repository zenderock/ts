import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_vision/views/app/detail_folder.dart';

class SearchFolder extends StatefulWidget {
  const SearchFolder({super.key});

  @override
  _SearchFolderState createState() => _SearchFolderState();
}

class _SearchFolderState extends State<SearchFolder> {
  final _formKey = GlobalKey<FormState>();

  void _onSubmitted(String value) {
    if (_formKey.currentState!.validate()) {
      Get.to(() => const DetailFolderScreen(), arguments: {"code": value});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              if (value.length == 9) {
                _onSubmitted(value);
              }
            },
            validator: (value) =>
                value!.isEmpty ? "Veuillez entrer votre nom" : null,
            style: const TextStyle(fontSize: 16, height: 2),
            decoration: const InputDecoration(
              hintText: "Code du dossier",
              constraints: BoxConstraints(
                minHeight: 20,
              ),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          )
        ],
      ),
    );
  }
}
