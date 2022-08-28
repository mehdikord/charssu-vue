import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem(
    this.word1,
    this.word2,
    this.word3,
    this.display,
    this.color, {
    Key? key,
  }) : super(key: key);

  final String word1, word2, word3;
  final Widget display;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(30),
                ),
              ),
              child: txt(word1),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              color: color,
              child: txt(word2),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              color: color,
              child: txt(word3),
            ),
          ),
          Flexible(
            flex: 2,
            child: display,
          ),
        ],
      ),
    );
  }

  txt(word) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          word,
          style: const TextStyle(
            color: Color(0xfff5f5f5),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
