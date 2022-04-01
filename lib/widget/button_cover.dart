import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import '../const/color.dart';

class ButtonCover extends StatefulWidget {
  final Widget? icon;
  const ButtonCover({Key? key, this.icon}) : super(key: key);

  @override
  _ButtonCoverState createState() => _ButtonCoverState();
}

class _ButtonCoverState extends State<ButtonCover> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed? Offset(10, 10) : Offset(20, 20);
    double blur = isPressed? 10 : 20;
    return GestureDetector(
      onTap: ()=> setState(() => isPressed = !isPressed),
      child: Listener(
        onPointerUp: (_) => setState(() => isPressed = false),
        onPointerDown: (_) => setState(() => isPressed = true),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsConsts.sky.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                  offset: -distance,
                  blurRadius: blur,
                  color: ColorsConsts.sky2.withOpacity(0.3),
                  inset: isPressed,
                ),
                BoxShadow(
                  offset: distance,
                  blurRadius: blur,
                  color: Color(0xFFA7A9AF).withOpacity(0.3),
                  inset: isPressed,
                ),
              ]
          ),
          child: widget.icon!,
        ),
      ),
    );
  }
}
