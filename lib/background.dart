import 'package:flutter/material.dart';
import 'package:memory_game/constants.dart';

class BackGround extends StatelessWidget {
  final Widget body;
  const BackGround({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [mainClr, altClr],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const Center(),
            Positioned(
              top: -20.0,
              right: -60.0,
              child: Image.asset('assets/Group.png'),
            ),
            Positioned(
              bottom: -50.0,
              left: -120.0,
              child: Image.asset('assets/Frame.png'),
            ),
            body,
          ],
        ),
      ),
    );
  }
}
