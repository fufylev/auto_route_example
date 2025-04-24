import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Unfocuser extends StatefulWidget {
  const Unfocuser({
    super.key,
    required this.child,
    this.isEnabled = true,
    this.minScrollDistance = 80.0,
  });

  final Widget child;
  final double minScrollDistance;
  final bool isEnabled;

  @override
  State<Unfocuser> createState() => _UnfocuserState();
}

class _UnfocuserState extends State<Unfocuser> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) {
      return widget.child;
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: widget.child,
    );
  }
}

class IgnoreUnfocuser extends SingleChildRenderObjectWidget {
  const IgnoreUnfocuser({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  IgnoreUnfocuserRenderBox createRenderObject(BuildContext context) {
    return IgnoreUnfocuserRenderBox();
  }
}

class ForceUnfocuser extends SingleChildRenderObjectWidget {
  const ForceUnfocuser({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  ForceUnfocuserRenderBox createRenderObject(BuildContext context) {
    return ForceUnfocuserRenderBox();
  }
}

class IgnoreUnfocuserRenderBox extends RenderPointerListener {}

class ForceUnfocuserRenderBox extends RenderPointerListener {}
