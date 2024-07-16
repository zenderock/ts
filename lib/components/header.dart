import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_vision/utils/constants/sizes.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _name;

  Future<String> getName() async {
    final SharedPreferences prefs = await _prefs;
    final String name = prefs.getString("lastname") ?? "";
    return name;
  }

  @override
  void initState() {
    super.initState();
    _name = getName();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bonjour';
    } else if (hour < 18) {
      return 'Bon après-midi';
    } else {
      return 'Bonsoir';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _name,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          final greeting = _getGreeting();
          return Text(greeting);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final greeting = _getGreeting();
          return Text("$greeting, ${snapshot.data}",
              style: const TextStyle(fontSize: TVSizes.fontLg));
        } else {
          final greeting = _getGreeting();
          return Text(greeting);
        }
      },
    );
  }
}
