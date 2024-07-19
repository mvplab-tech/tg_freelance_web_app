// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PulseWrap extends StatelessWidget {
  final List<Widget> children;
  final WrapAlignment? alignment;
  const PulseWrap({
    Key? key,
    required this.children,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 8,
      alignment: alignment ?? WrapAlignment.start,
      children: children,
    );
  }
}
