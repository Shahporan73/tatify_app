// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final bool showObscure;
  final bool? readOnly;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? inputTextColor;
  final VoidCallback? onTap;
  final Widget? prefixWidget;
  const CustomPasswordField({
    Key? key,
    required this.hintText,
    required this.showObscure,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.fillColor,
    this.borderColor,
    this.hintTextColor,
    this.readOnly,
    this.inputTextColor,
    this.onTap,
    this.prefixWidget,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        obscureText: widget.showObscure ? _obscureText : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent, width: 1),
          ),
          prefixIcon: widget.prefixWidget ??
              (widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.grey) : null),
          suffixIcon: widget.showObscure
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: GoogleFonts.urbanist(
              fontSize: 14, color: widget.hintTextColor ?? Colors.grey),
        ),
        style: GoogleFonts.urbanist(
          fontSize: 14,
          color:  Colors.black,
          fontWeight: FontWeight.w500,
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
