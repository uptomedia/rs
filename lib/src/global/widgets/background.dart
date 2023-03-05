import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff251A40), Color(0xff17191D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}
