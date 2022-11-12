import 'package:budi/Utilities/AppColor.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  String label;
  Color color;
  double height;
  double width;
  Color? borderColor;
  Color? lableColor;
  VoidCallback onTap;

  AppButton({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.label,
    this.lableColor,
    this.borderColor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.only(left: 25, right: 25, top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: widget.borderColor == null
                    ? AppColor.BUTTON_COLOR
                    : widget.borderColor!),
            color: widget.color,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
                color: widget.lableColor == null
                    ? Colors.white
                    : AppColor.BUTTON_COLOR),
          )),
    );
  }
}
