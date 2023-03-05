import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class AppDrawer extends StatelessWidget {
  final Widget mainScreen;
  final ZoomDrawerController controller;
  const AppDrawer(
      {super.key, required this.mainScreen, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller,
      style: DrawerStyle.defaultStyle,
      menuScreen: const DrawerMenu(),
      duration: const Duration(milliseconds: 500),
      mainScreen: mainScreen,
      borderRadius: 24.0,
      showShadow: true,
      mainScreenScale: 0.1,
      mainScreenTapClose: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: AppColors.secodary,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.linear,
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("Profile"),
            onTap: () {
              // Get.to(ProfileScreen());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("Cart History"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("Settings"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("Subscriptions History"),
          ),
        ),
      ],
    );
  }
}
