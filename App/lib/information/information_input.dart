import 'package:flutter/material.dart';

class InformationInput extends StatelessWidget {
  const InformationInput({
    required this.title,
    required this.input,
    this.required = false,
    this.width = 0.7,
    this.height = 45,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget input;
  final bool required;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              "$title :",
              style: const TextStyle(
                color: Color(0xff253567),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              required
                  ? const Text(
                      "*",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
              Container(
                width: MediaQuery.of(context).size.width * width,
                height: height,
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xffe1e1e1),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30),
                  ),
                ),
                child: input,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
