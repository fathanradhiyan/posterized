import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:posterized/const/color.dart';
import 'package:posterized/pages/opening_page.dart';

AwesomeDialog successDialog(
    BuildContext context, String titleDialog, String descDialog) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      title: titleDialog,
      desc: descDialog,
      btnOkOnPress: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const OpeningPage()));
      },
      btnOkIcon: Icons.check_circle,
      btnOkColor: ColorsConsts.success);
}