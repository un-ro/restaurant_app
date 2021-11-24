import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExceptionCard extends StatelessWidget {
  final String assetPath;
  final String message;
  const ExceptionCard({
    Key? key,
    required this.assetPath,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            assetPath,
            height: 200.0,
            width: 200.0,
          ),
          Text(message)
        ],
      ),
    );
  }
}
