import 'package:flutter/material.dart';

/*Yara Adel Mohamed*/
class CustomFading extends StatefulWidget {
  const CustomFading({super.key, required this.child});
  final Widget child;
  @override
  State<CustomFading> createState() => _CustomFadingState();
}

class _CustomFadingState extends State<CustomFading>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 800));
    animation = Tween<double>(begin: .2, end: .8).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: widget.child,
    );
  }
}
