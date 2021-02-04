import 'package:flutter/material.dart';

class LoaderHUD extends StatelessWidget {
  LoaderHUD({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.6,
    this.color = Colors.grey,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  final Widget child;
  final Color color;
  final bool dismissible;
  final bool inAsyncCall;
  final double opacity;
  final Widget progressIndicator = const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    return Stack(
      children: [
        child,
        Opacity(
          child: ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        Center(child: progressIndicator),
      ],
    );
  }
}
