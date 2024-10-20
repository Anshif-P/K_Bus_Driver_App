import 'package:flutter/material.dart';
import 'package:k_bus_driver/util/constance/app_colors.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  final bool textVisibility;
  final FormFieldValidator validator;
  bool isObscure = true;
  bool isNumber;
  TextFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    this.isObscure = false,
    this.textVisibility = false,
    this.isNumber = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        keyboardType:
            widget.isNumber ? TextInputType.phone : TextInputType.text,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isObscure,
        decoration: InputDecoration(
          isDense: true,
          constraints: const BoxConstraints(maxHeight: 70, minHeight: 35),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: widget.textVisibility
              ? IconButton(
                  icon: Icon(widget.isObscure
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      widget.isObscure = !widget.isObscure;
                    });
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintStyle: AppText.mediumGrey,
        ),
      ),
    );
  }
}
