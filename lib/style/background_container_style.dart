import 'package:flutter/material.dart';

class BackContainer extends StatelessWidget {
  final Widget child;
  const BackContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}

