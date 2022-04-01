import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:posterized/const/color.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:posterized/widget/button_cover.dart';

class ScoringBar extends StatefulWidget {
  final String? title;
  final ValueSetter<int>? scoring;
  const ScoringBar({Key? key, this.title, this.scoring}) : super(key: key);

  @override
  _ScoringBarState createState() => _ScoringBarState();
}

class _ScoringBarState extends State<ScoringBar> {
  int point = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        color: ColorsConsts.sky.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title!,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ButtonCover(icon: IconButton(
                        onPressed: () {
                          setState(() {
                            point = max(0, point -1);
                            widget.scoring!(point);
                          });
                        },
                        icon: const Icon(Icons.remove),
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                      )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                          child: Text(
                            point.toString(),
                            style: GoogleFonts.barlow(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonCover(icon: IconButton(
                        onPressed: () {
                          setState(() {
                            point = min(100, point +1);
                            widget.scoring!(point);
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget buttonCover(Widget icon) {
    Offset distance = isPressed? Offset(10, 10) : Offset(20.6, 20.6);
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
          child: icon,
        ),
      ),
    );
}
}
