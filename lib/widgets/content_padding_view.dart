import 'package:flutter/material.dart';

class ContentPaddingView extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ContentPaddingView({super.key, required this.child, this.maxWidth = 800});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
