import 'package:flutter/material.dart';
import '../../utils/margins.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final double titleFontSize;
  final bool isText;
  final Color primaryColor;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      this.title,
      this.titleFontSize = 15,
      this.isText = false,
      this.primaryColor = const Color(0xFFF9923B)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isText
        ? TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(width(50), height(10)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: primaryColor),
            child: Text(
              title!,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                  fontSize: titleFontSize),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                minimumSize: Size(width(120), height(38)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(
              title!,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: titleFontSize),
            ),
          );
  }
}
