import 'package:flutter/material.dart';

class BGWidget extends StatelessWidget {
  const BGWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.multiply,
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Color(0xff2b346f),
            Color(0xff0f7081),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: Image.asset(
        "assets/images/pattern.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
