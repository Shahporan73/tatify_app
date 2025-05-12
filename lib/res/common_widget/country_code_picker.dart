// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tatify_app/res/custom_style/custom_style.dart';

class CountryCodePicker extends StatefulWidget {
  final String titleText;
  final String hintText;
  final TextEditingController? controller;

  CountryCodePicker({
    Key? key,
    required this.titleText,
    required this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  final FocusNode _focusNode = FocusNode();
  PhoneNumber? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Method to update phone number
  void _onInputChanged(PhoneNumber number) {
    setState(() {
      _phoneNumber = number;
    });

    // If a controller is provided, set the phone number text
    if (widget.controller != null) {
      widget.controller!.text = number.phoneNumber ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        Text(
          widget.titleText,
          style: customLabelStyle,
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusNode); // Focus on tap
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07, // Adjusted height
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: _focusNode.hasFocus ? Colors.red : Color(0xffcacaca),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InternationalPhoneNumberInput(
                focusNode: _focusNode,
                inputBorder: InputBorder.none,
                onInputChanged: _onInputChanged,
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useEmoji: true,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(
                  color: _focusNode.hasFocus ? Colors.red : Colors.black,
                ),
                initialValue: PhoneNumber(isoCode: 'LT'),
                formatInput: true,
                inputDecoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.urbanist(
                      color: Color(0xff595959),
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
