import 'package:flutter/material.dart';

import 'widget/bg_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static const routeName = '/loading';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              const BGWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Logo.png",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Image.asset(
                        "assets/images/Line.png",
                        width: 240,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                          "assets/images/Name.png",
                          width: 290,
                        ),
                      ),
                      const Text(
                        "charssu",
                        style: TextStyle(
                          color: Color(0xfffefefe),
                          fontSize: 18,
                          letterSpacing: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "نسخه : ۱,۴,۵",
                          style: TextStyle(
                            color: Color(0xfffefefe),
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
