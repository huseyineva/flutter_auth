import 'package:flutter/material.dart';

class CustomLink extends StatelessWidget {
  final String rowText;
  final String navigatorText;
  final navigatorWay;

  CustomLink({
    required this.rowText,
    required this.navigatorText,
    required this.navigatorWay,
  });

  @override
  Widget build(BuildContext context) {
    Color colorPurple = const Color(0xFF5C27FE);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rowText,
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        const SizedBox(
          width: 5.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigatorWay),
            );
          },
          child: Text(
            navigatorText,
            style: TextStyle(
              color: colorPurple,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
