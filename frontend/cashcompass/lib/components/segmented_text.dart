import 'package:flutter/cupertino.dart';

class SegmenedText extends StatelessWidget {
  final String title;
  const SegmenedText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
