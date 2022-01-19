import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/ui/utils/colors.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

abstract class ProgressDialog {
  static void show(BuildContext context) {
    final isDark = context.isDarkMode;
    final progressColorDialog = isDark?primaryDarkColor:primaryLigthColor;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => WillPopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: progressColorDialog,
            ),
          ),
          onWillPop: () async => false),
    );
  }
}
