import 'package:flutter/material.dart';

class SecureProgressBar extends StatelessWidget {
  const SecureProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 2,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: StreamBuilder<double>(
          stream: progress,
          builder: (context, snapshot) => LayoutBuilder(
            builder: (context, constraints) => Container(
              height: 2,
              width: constraints.maxWidth * (snapshot.data ?? 0.1),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ));
  }

  Stream<double> get progress {
    return Stream.periodic(const Duration(milliseconds: 1000), (x) => x / 10).take(10);
  }
}
