import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_ad/app/modules/home/views/home_view.dart';
import 'package:pink_ad/utilities/custom_widgets/auth_dialog.dart';
import 'package:pink_ad/utilities/functions/show_toast.dart';
import 'package:upgrader/upgrader.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const popDuration = Duration(seconds: 2);
  final box = GetStorage();
  DateTime? currentBackPressTime;
  final canPop = false.obs;
  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: _tabIndex);

    super.initState();
  }

  Future<void> onPopInvoked(bool popped) async {
    if (popped) return;
    // If current state can be popped without closing the app then do nothing
    if (Get.global(null).currentState?.canPop() ?? false) {
      if (await Get.global(null).currentState!.maybePop()) return;
    }
    final now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > popDuration) {
      currentBackPressTime = now;
      showToast(message: 'Press BACK again to Exit').then((value) => canPop.value = false);
      canPop.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userType = box.read('user_type');
      return UpgradeAlert(
        dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        child: PopScope(
          canPop: canPop.value,
          onPopInvoked: onPopInvoked,
          child: Stack(
            children: [
              Scaffold(
                body: HomeView(),
              ),
              if (userType == null)
                Center(
                  child: AuthDialog(),
                ),
            ],
          ),
        ),
      );
    });
  }
}
