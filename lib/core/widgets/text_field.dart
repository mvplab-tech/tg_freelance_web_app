// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PulseTextField extends StatelessWidget {
  final double? height;
  final TextInputType? inputType;
  final String hintText;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController controller;
  final bool? showCounter;
  final List<TextInputFormatter>? formatters;
  const PulseTextField({
    Key? key,
    this.height,
    this.inputType,
    required this.hintText,
    this.maxLines,
    this.maxLength,
    required this.controller,
    this.showCounter,
    this.formatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 150,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffF2F2F7),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: TextField(
                inputFormatters: formatters,
                keyboardType: inputType ?? TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: hintText,
                  //  'Im great for this job because...',
                ),
                maxLines: maxLines ?? 6,
                maxLength: maxLength ?? 1000,
                controller: controller,
                buildCounter: showCounter ?? true
                    ? null
                    : (context,
                        {required currentLength,
                        required isFocused,
                        required maxLength}) {
                        return const SizedBox.shrink();
                      }),
          ),
        ));
  }
}
