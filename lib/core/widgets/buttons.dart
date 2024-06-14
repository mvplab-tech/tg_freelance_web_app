// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';

class PulseButton extends StatefulWidget {
  final bool isLoading;
  final bool enabled;
  final String text;
  final VoidCallback action;

  const PulseButton({
    Key? key,
    required this.isLoading,
    required this.enabled,
    required this.text,
    required this.action,
  }) : super(key: key);

  @override
  State<PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.enabled && !widget.isLoading ? widget.action : () {},
      style: ButtonStyle(
        backgroundColor: widget.enabled
            ? WidgetStatePropertyAll(
                Colors.green[200],
              )
            : WidgetStatePropertyAll(
                Colors.grey[400],
              ),
      ),
      child: !widget.isLoading
          ? Text(
              widget.text,
              style: context.styles.body1.copyWith(
                  color: widget.enabled ? Colors.black : Colors.black26),
            )
          : const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
            ),
    );
  }
}
