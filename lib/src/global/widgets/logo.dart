import 'package:flutter/material.dart';
import 'package:rs/src/global/utils/colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      width: 136,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.primary.withOpacity(0.6),
            blurRadius: 25,
            spreadRadius: 1),
      ], color: AppColors.primary, borderRadius: BorderRadius.circular(120)),
      child: Image.asset('assets/imgs/ramizLogo.png'),
    );
  }
}
