import 'package:flutter/material.dart';

class square_tile extends StatelessWidget {
  final String imagePath;

  const square_tile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ), //box deco
      child: Image.asset(
        imagePath,
        height: 40,
      ), //images
    );
  }
}