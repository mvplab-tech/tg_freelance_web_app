// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tg_freelance/core/extensions/build_context_extension.dart';

class PulseCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? insets;
  const PulseCard({
    Key? key,
    required this.child,
    this.insets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding:
            insets ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: child,
      ),
    );
  }
}

class DisplayWidget extends StatelessWidget {
  final String label;
  final Widget child;
  final double? height;
  const DisplayWidget({
    Key? key,
    required this.label,
    required this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PulseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.styles.headline,
          ),
          SizedBox(
            height: height ?? 8,
          ),
          child
        ],
      ),
    );
  }
}
