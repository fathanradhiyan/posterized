import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posterized/const/color.dart';
import 'package:posterized/pages/poster_page.dart';
import 'package:posterized/widget/button_cover.dart';
import 'package:posterized/widget/scoring_bar.dart';

class InputPage extends StatefulWidget {
  final String? name;

  const InputPage({Key? key, this.name}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int threePoint = 0;
  int finalScore = 0;
  int twoPoint = 0;
  int onePoint = 0;

  int? rebPoint;
  int? astPoint;
  int? stlPoint;
  int? blkPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.sky2,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 50,
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
                child: Image(
                  image: AssetImage('assets/images/poster_logo.png'),
                )),
          ),
        ),
        backgroundColor: ColorsConsts.sky,
        title: Text(
          'Scoring Page',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Badge(
              badgeContent: Text(
                finalScore > 1 ? 'Points' : 'Point',
                style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              badgeColor: ColorsConsts.white,
              shape: BadgeShape.square,
              borderRadius: BorderRadius.circular(4),
              position: const BadgePosition(
                end: -40,
                top: 10,
              ),
              child: Text(
                finalScore.toString(),
                style: GoogleFonts.teko(
                  fontSize: 72,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.name!.toUpperCase(),
                  style: GoogleFonts.cairo(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )),
          twoPointBar('2 Points Made'),
          const SizedBox(height: 3,),
          threePointBar('3 Points Made'),
          const SizedBox(height: 3,),
          freeThrowBar('Free Throws Made'),
          const SizedBox(height: 3,),
          ScoringBar(
            title: 'Rebound',
            scoring: (rebound) {
              setState(() {
                rebPoint = rebound;
              });
            },
          ),
          const SizedBox(height: 3,),
          ScoringBar(
            title: 'Assist',
            scoring: (assist) {
              setState(() {
                astPoint = assist;
              });
            },
          ),
          const SizedBox(height: 3,),
          ScoringBar(
            title: 'Steal',
            scoring: (steal) {
              setState(() {
                stlPoint = steal;
              });
            },
          ),
          const SizedBox(height: 3,),
          ScoringBar(
            title: 'Block',
            scoring: (block) {
              setState(() {
                blkPoint = block;
              });
            },
          ),
        ],
      ),
      bottomSheet: footerButton(),
    );
  }

  Widget threePointBar(String title) {
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
                title,
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
                            threePoint = max(0, threePoint - 1);
                            finalScore = max(0, finalScore - 3);
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
                            threePoint.toString(),
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
                            threePoint = min(100, threePoint + 1);
                            finalScore = min(100, finalScore + 3);
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget twoPointBar(String title) {
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
                title,
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
                            twoPoint = max(0, twoPoint - 1);
                            finalScore = max(0, finalScore - 2);
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
                            twoPoint.toString(),
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
                            twoPoint = min(100, twoPoint + 1);
                            finalScore = min(100, finalScore + 2);
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget freeThrowBar(String title) {
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
                title,
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
                            onePoint = max(0, onePoint - 1);
                            finalScore = max(0, finalScore - 1);
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
                            onePoint.toString(),
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
                            onePoint = min(100, onePoint + 1);
                            finalScore = min(100, finalScore + 1);
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget footerButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PosterPage(
                      player: widget.name!,
                      points: finalScore,
                      threepoints: threePoint,
                      rebound: rebPoint ?? 0,
                      assist: astPoint ?? 0,
                      steal: stlPoint ?? 0,
                      block: blkPoint ?? 0,
                    ))),
        child: Text(
          'Next'.toUpperCase(),
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return ColorsConsts.sky;
          }),
          textStyle: MaterialStateProperty.resolveWith((states) {
            // If the button is pressed, return size 40, otherwise 20
            if (states.contains(MaterialState.pressed)) {
              return GoogleFonts.cairo(fontSize: 40);
            }
            return GoogleFonts.cairo(fontSize: 20);
          }),
        ),
      ),
    );
  }
}
