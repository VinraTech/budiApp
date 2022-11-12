import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  TextEditingController? controller;
  String? hintText;
  String? prefixIcon;
  bool? obscureText;
  bool? isSearch;
  bool? enable;
  VoidCallback? onFilterTap;

  AppTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.obscureText,
      this.isSearch,
      this.enable,
      this.onFilterTap})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: TextField(
          obscureText: widget.obscureText!,
          enabled: widget.enable!,
          controller: widget.controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Image.asset(
                widget.prefixIcon!,
                scale: 2.5,
              ),
              suffixIcon: widget.isSearch == true
                  ? GestureDetector(
                      onTap: widget.onFilterTap,
                      child: Image.asset(
                        Assets.icFilter,
                        scale: 3,
                      ),
                    )
                  : SizedBox(),
              labelText: widget.hintText,
              labelStyle: TextStyle(color: AppColor.TEXT_COLOR)),
        ));
  }
}
