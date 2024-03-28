import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  final Widget child;
  final String animationType;
  final Duration duration;
  final Curve curve;

  AnimationWidget({
    required this.child,
    required this.animationType,
    required this.duration,
    required this.curve,
  });

  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    switch (widget.animationType) {
      case 'fade':
        _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
        break;
      case 'slide':
        _animation = Tween<double>(begin: -1, end: 0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case 'scale':
        _animation = Tween<double>(begin: 0.90, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case 'translate':
        _animation = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case 'bubbly':
        _animation = Tween<double>(begin: -1, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case 'fade_slide':
        _animation = Tween<double>(begin: -1, end: 0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        // com.example.baderia_tech_wave
        //baderia.collegeapp.com
          break;
      case 'bouncy':
        _animation = Tween<double>(begin: -1, end: 0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        // Transform.scale(
        //   scale: 1 - (_controller.value * 0.3),
        // );

        break;
      case 'shake':
        _animation = TweenSequence<double>([
          TweenSequenceItem<double>(
            tween: Tween(begin: 0, end: 10),
            weight: 1,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 10, end: -10),
            weight: 1,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: -10, end: 10),
            weight: 1,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 10, end: 0),
            weight: 1,
          ),
        ]).animate(_controller);
        break;
      default:
        _animation = null;
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        switch (widget.animationType) {
          case 'fade':
            return Opacity(
              opacity: _animation!.value,
              child: widget.child,
            );
          case 'slide':
            return Transform.translate(
              offset: Offset(_animation!.value * MediaQuery.of(context).size.width, 0),
              child: widget.child,
            );
          case 'scale':
            return Transform.scale(
              scale: _animation!.value,
              child: widget.child,
            );
          case 'translate':
            return Transform.translate(
              offset: Offset(0, _animation!.value * MediaQuery.of(context).size.height),
              child: widget.child,
            );
          case 'bubbly':
            return Transform.scale(
              scale: _animation!.value,
              child: widget.child,
            );
          case 'fade_slide':
            return Opacity(
              opacity: 1 - (_animation!.value.abs() / 1),
              child: Transform.translate(
                offset: Offset(_animation!.value * MediaQuery.of(context).size.width, 0),
                child: widget.child,
              ),
            );
          case 'shake':
            return Transform.translate(
              offset: Offset(_animation!.value, 0),
              child: widget.child,
            );
          default:
            return SizedBox(); // Return empty widget by default
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
//
// class FadeTransitionWidget extends StatefulWidget {
//   final Widget child;
//
//   FadeTransitionWidget({required this.child});
//
//   @override
//   _FadeTransitionWidgetState createState() => _FadeTransitionWidgetState();
// }
//
// class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _animation.value,
//           child: widget.child,
//         );
//       },
//     );
//   }
// }
