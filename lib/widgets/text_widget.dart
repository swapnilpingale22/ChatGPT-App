import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.label,
    this.color = Colors.white,
    this.fontsize = 18,
    this.fontWeight,
    this.textAlign,
  }) : super(
          key: key,
        );
  final String label;
  final Color color;
  final double fontsize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      label,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
      softWrap: true,
    );
  }
}
