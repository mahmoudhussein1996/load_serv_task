import 'package:flutter/material.dart';
import 'package:load_serv_task/core/theme/colors.dart';
import 'package:provider/provider.dart';

class TextDefaultWidget extends StatelessWidget {
  const TextDefaultWidget(
      {Key? key,
        required this.title,
        this.fontSize,
        this.fontWeight,
        this.fontFamily,
        this.color,
        this.gradientColors,
        this.maxLines,
        this.underlineText,
        this.lineThrough,
        this.textBaseline,
        this.textAlign,
        this.textOverflow,})
      : super(key: key);
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final Paint? gradientColors;
  final String title;
  final int? maxLines;
  final bool? underlineText;
  final bool? lineThrough;
  final TextBaseline? textBaseline;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? Colors.black,
          textBaseline: textBaseline,
          fontFamily: "Almarai",
          foreground: gradientColors,
          overflow:textOverflow?? TextOverflow.ellipsis,
          decoration: underlineText == true
              ? TextDecoration.underline
              : lineThrough == true ? TextDecoration.lineThrough : TextDecoration.none),
      maxLines: maxLines ?? 5,
      overflow:textOverflow?? TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}

