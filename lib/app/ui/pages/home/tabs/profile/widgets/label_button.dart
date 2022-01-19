
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/ui/utils/colors.dart';
import 'package:flutter_application_1/app/ui/utils/dark_mode_extensions.dart';


class LabelButton extends StatelessWidget {
  final String label, value;
  final VoidCallback? onPressed;
  final IconData? iconData;
  const LabelButton(
      {Key? key,
      required this.label,
      required this.value,
      this.onPressed,
      required,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final iconColor = isDark ? primaryDarkColor: primaryLigthColor;
    return MaterialButton(
      onPressed: (){
        if(onPressed!=null){
          onPressed!();
        }
      },
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if(onPressed!=null)
              Icon(
                iconData,
                size: 25,
                color: iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
