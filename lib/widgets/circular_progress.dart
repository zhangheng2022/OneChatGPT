import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  final color;
  const CircularProgressWidget({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
