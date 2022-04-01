import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posterized/const/color.dart';
import 'package:badges/badges.dart';
import 'package:posterized/widget/awesome_success_dialog.dart';
import 'package:screenshot/screenshot.dart';

class PosterPage extends StatefulWidget {
  final String? player;
  final int? points;
  final int? rebound;
  final int? assist;
  final int? steal;
  final int? block;
  final int? freeThrow;
  final int? threepoints;

  const PosterPage(
      {Key? key,
      this.player,
      this.points,
      this.rebound,
      this.assist,
      this.steal,
      this.block,
      this.freeThrow,
      this.threepoints})
      : super(key: key);

  @override
  _PosterPageState createState() => _PosterPageState();
}

class _PosterPageState extends State<PosterPage> {
  Uint8List? _imageFile;
  File? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final screenshotController = ScreenshotController();
  bool isLoading = false;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //temporary
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to Pick image: $e');
    }
  }

  Future<Future> showImageSource(BuildContext context) async {
    if (Platform.isAndroid) {
      return showModalBottomSheet(
          backgroundColor: ColorsConsts.sky2,
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: ColorsConsts.sky,
                    ),
                    title: Text(
                      'Camera',
                      style: GoogleFonts.cairo(
                          color: ColorsConsts.sky, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.image,
                        color: ColorsConsts.sky,
                      ),
                      title: Text(
                        'Gallery',
                        style: GoogleFonts.cairo(
                            color: ColorsConsts.sky,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }),
                ],
              ));
    } else {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      child: const Text('Camera'),
                      onPressed: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      }),
                  CupertinoActionSheetAction(
                      child: const Text('Gallery'),
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }),
                ],
              ));
    }
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'posterized_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsConsts.sky2,
      body: Screenshot(
        controller: screenshotController,
        child: getBody(),
      ),
      bottomSheet: Container(
        color: ColorsConsts.sky2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buttonRow(),
        ),
      ),
    ));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height,
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF64B6B6), BlendMode.srcATop),
                          child: LottieBuilder.asset(
                            'assets/json/take_picture.json',
                          ),
                        )),
                    Text(
                      'Pick Image from \n Gallery or Camera',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          color: ColorsConsts.sky,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
          // Image.asset(
          //         'assets/images/dummy.jpg',
          //         fit: BoxFit.cover,
          //       )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //NAME
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 4),
              color: ColorsConsts.blackgrey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.player!.toUpperCase(),
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //PTS
            widget.points == 0
                ? const SizedBox()
                : statsBadges(widget.points.toString(), 'PTS'),
            widget.rebound == 0
                ? const SizedBox()
                : statsBadges(widget.rebound.toString(), 'REB'),
            widget.assist == 0
                ? const SizedBox()
                : statsBadges(widget.assist.toString(), 'AST'),
            widget.steal == 0
                ? const SizedBox()
                : statsBadges(widget.steal.toString(), 'STL'),
            widget.block == 0
                ? const SizedBox()
                : statsBadges(widget.block.toString(), 'BLK'),
            widget.threepoints == 0
                ? const SizedBox()
                : statsBadges(widget.threepoints.toString(), '3PM'),
          ],
        ),
        Positioned(
          bottom: -15,
          right: 0,
          child: Image(
            height: 100,
            color: Colors.white.withOpacity(0.3),
            // colorBlendMode: BlendMode.softLight,
            image: const AssetImage('assets/images/poster_logo.png'),
          ),
        ),
      ],
    );
  }

  Widget buttonRow() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () async {
              return await showImageSource(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (image != null) {
                  return Colors.grey;
                }
                return ColorsConsts.sky;
              }),
            ),
            child: Text(
              image != null ? 'CHANGE IMAGE' : 'PICK IMAGE',
              style: GoogleFonts.cairo(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: image == null
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final capturedImg = await screenshotController.capture();
                    if (capturedImg == null) {
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }
                    await saveImage(capturedImg);
                    setState(() {
                      isLoading = false;
                    });
                    successDialog(context, "Done", 'Your Image is Saved')
                        .show();
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (image != null) {
                  return ColorsConsts.sky;
                }
                return Colors.grey;
              }),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 30,
                    child: SpinKitThreeBounce(
                      size: 25,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'GENERATE',
                    style: GoogleFonts.cairo(fontSize: 18),
                  ),
          ),
        ),
      ],
    );
  }

  Widget statsBox(String text) {
    return Container(
      width: 50,
      margin: const EdgeInsets.only(bottom: 2),
      color: ColorsConsts.blackgrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.barlow(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget statsBadges(String score, String category) {
    return Badge(
      badgeContent: Text(
        category,
        style: GoogleFonts.cairo(
          color: Colors.black,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      badgeColor: ColorsConsts.white,
      position: const BadgePosition(
        end: -16,
      ),
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(4),
      child: statsBox(score),
    );
  }
}
