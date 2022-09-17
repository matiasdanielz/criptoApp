import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: Center(
        child: SpinKitFadingCircle(
          size: 100,
          duration: const Duration(seconds: 1),
          itemBuilder: (context, index) {
            final colors = [
              Colors.white,
            ];
            final color = colors[index % colors.length];

            return DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
