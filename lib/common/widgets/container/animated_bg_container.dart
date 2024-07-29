import 'package:flutter/material.dart';

class AnimatedBGContainer extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final BoxBorder? border;
  final Duration animationDuration;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow>? boxShadow;
  final Widget child;
  const AnimatedBGContainer({
    super.key,
    required this.child,
    required this.startColor,
    required this.endColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.animationDuration = const Duration(seconds: 1),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  });

  @override
  State<AnimatedBGContainer> createState() => _AnimatedBGContainerState();
}

class _AnimatedBGContainerState extends State<AnimatedBGContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _startColorAnimation;
  late Animation _endColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _startColorAnimation = ColorTween(
      begin: widget.startColor,
      end: widget.endColor,
    ).animate(_controller);
    _endColorAnimation = ColorTween(
      begin: widget.endColor,
      end: widget.startColor,
    ).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Container(
        decoration: BoxDecoration(
          boxShadow: widget.boxShadow,
          borderRadius: widget.borderRadius,
          border: widget.border,
          gradient: LinearGradient(
            colors: [
              _startColorAnimation.value,
              _endColorAnimation.value,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }
}
