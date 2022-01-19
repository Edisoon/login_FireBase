import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  String? initialValue,
}) async {
  final isDark = context.isDarkMode;
  final textColor = isDark? Colors.white70 : Colors.black54;
  String value = initialValue??'';
  final result = await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: CupertinoTextField(
        autofocus: true,
        controller: TextEditingController()..text = initialValue??'',
        style: TextStyle(color:textColor),
        onChanged: (text) {
          value = text;
        },
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text("GUARDAR"),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, value);
          },
        ),CupertinoDialogAction(
          child: const Text("CANCELAR"),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            // controller.dispose();
          },
        ),
      ],
    ),
  );

  
  // controller.dispose();


  if (result != null && result.trim().isEmpty){
    return null;
  }
  return result;
}
