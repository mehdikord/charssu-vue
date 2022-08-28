import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:charssu/main.dart';
import 'package:charssu/providers/auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ShaderMask(
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
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Logo.png",
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Image.asset(
                      "assets/images/Line.png",
                      width: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        "assets/images/Name.png",
                        width: 140,
                      ),
                    ),
                    const Text(
                      "charssu",
                      style: TextStyle(
                        color: Color(0xfffefefe),
                        fontSize: 12,
                        letterSpacing: 6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              "درباره ما",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: const Icon(Icons.info_outline),
            onTap: () => launchUrlString("https://charssu.ir"),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "‌خروج",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      title: Text(
                        "هشدار",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.brightness ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      content: const Text("آیا مطمئن هستید؟"),
                      actions: [
                        TextButton(
                          child: const Text("خیر"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text(
                            "بله",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Provider.of<Auth>(context, listen: false).logout();
                            Navigator.of(context)
                                .pushReplacementNamed(MyHomePage.routeName);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
