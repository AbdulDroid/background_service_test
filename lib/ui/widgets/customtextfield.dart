import 'package:flutter/material.dart';
import '../../utils/margins.dart';

class CustomTextField extends StatefulWidget {
  final String? title, hintText, initialValue;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool filled;
  final FormFieldValidator<String?>? validator;
  final double titleFontSize;
  final double containerHeight;
  final double fieldHeight;
  const CustomTextField(
      {Key? key,
      this.title,
      this.obscure = false,
      this.controller,
      this.inputType,
      this.hintText,
      this.filled = false,
      this.validator,
      this.titleFontSize = 14,
      this.containerHeight = 60,
      this.fieldHeight = 40,
      this.initialValue})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final obscureAwareSize = widget.obscure ? 45.0 : 15.0;
    return SizedBox(
      height: height(widget.containerHeight),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.title!,
              style: TextStyle(
                fontSize: widget.titleFontSize,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
                color: const Color(0xFF384571),
              ),
            ),
          ),
          verticalSpaceTiny,
          Container(
            height: height(widget.fieldHeight),
            width: double.infinity,
            child: TextFormField(
              initialValue: widget.initialValue,
              keyboardType: widget.inputType,
              controller: widget.controller,
              obscureText: !isPasswordVisible && widget.obscure,
              validator: widget.validator,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 0.8),
              decoration: InputDecoration(
                filled: widget.filled,
                fillColor: const Color(0xA0E6E6E6),
                hintText: widget.hintText,
                contentPadding:
                    EdgeInsets.only(left: 17, bottom: widget.fieldHeight / 2, right: 17),
                hintStyle: TextStyle(
                    color: const Color(0XFF88879C),
                    fontWeight: FontWeight.w500,
                    fontSize: obscureAwareSize),
                suffixIcon: widget.obscure
                    ? IconButton(
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        color: const Color(0XFFCCD2E3))
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xA0E6E6E6)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xA0E6E6E6)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
