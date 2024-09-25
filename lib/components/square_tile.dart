import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String path;
  const SquareTile({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400)),
      child: Image.asset(
        path,
        height: 60,
      ),
    );
  }
}
