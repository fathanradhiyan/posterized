import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posterized/const/color.dart';

class ScoringBar extends StatefulWidget {
  final String title;
  final ValueSetter<int> scoring;
  ScoringBar({Key key, this.title, this.scoring}) : super(key: key);

  @override
  _ScoringBarState createState() => _ScoringBarState();
}

class _ScoringBarState extends State<ScoringBar> {
  int point = 0;

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
                widget.title,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        point = max(0, point -1);
                        widget.scoring(point);
                      });
                    },
                    icon: Icon(Icons.remove),
                    splashColor: ColorsConsts.snow,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      point.toString(),
                      style: GoogleFonts.barlow(fontSize: 24),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        point = min(100, point +1);
                        widget.scoring(point);
                      });
                    },
                    icon: Icon(Icons.add),
                    splashColor: ColorsConsts.snow,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
