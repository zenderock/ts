import 'package:get/get.dart';
import 'package:the_vision/views/app/dashboard.dart';
import 'package:the_vision/views/app/folders.dart';
import 'package:the_vision/views/app/notifications.dart';
import 'package:the_vision/views/app/profile.dart';

class BottomNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final Rx<bool> isVisible = true.obs;
  final screens = [
    const DashboardScreen(),
    const FoldersScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
}
