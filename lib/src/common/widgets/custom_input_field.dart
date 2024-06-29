import 'package:flutter/material.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final bool isSecure;
  final IconData icon;
  bool isIconRequired = false;
  final Function(String)? onChanged;
  double contentPaddingVertical = 20;
  double contentPaddingHorizontal = Dimensions.zDefaultPadding;
  //write a function that will work on

  //return a bool in onDone
  bool Function(String)? onDone;
  double radius = Dimensions.zButtonRadiusLarge;

  final TextEditingController controller;
  CustomInputField({
    this.hintText = '',
    this.isSecure = false,
    this.icon = Icons.email,
    this.isIconRequired = false,
    required this.controller,
    this.onChanged,
    this.onDone,
    this.radius = 16,
    this.contentPaddingVertical = 20,
    this.contentPaddingHorizontal = Dimensions.zDefaultPadding,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isSecure ? !isPasswordVisible : false,
          scrollPadding: const EdgeInsets.only(bottom: 100),
          style: const TextStyle(color: zTextColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: zBackgroundColor.withOpacity(0),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                right: Dimensions.paddingSizeLarge,
              ),
              child: widget.isIconRequired
                  ? InkWell(
                      onTap: widget.isSecure
                          ? () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            }
                          : () {},
                      child: Icon(
                        widget.isSecure
                            ? isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility
                            : widget.icon,
                        color: zPrimaryColor,
                      ),
                    )
                  : null,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.contentPaddingVertical,
                horizontal: widget.contentPaddingHorizontal),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: zGraySwatch[400],
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: zGraySwatch[200]!,
                width: 1,
              ),
            ),

            /// This is the border that appears when the field is not focused
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: zGraySwatch[200]!,
                width: 1,
              ),
            ),

            ///This is the border that appears when the field is focused or selected
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(
                color: zPrimaryColor,
                width: 1,
              ),
            ),
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
            //widget.onDone!();
          },
          textInputAction: TextInputAction.done,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
