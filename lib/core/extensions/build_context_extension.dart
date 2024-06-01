import 'package:flutter/material.dart';
import 'package:tg_freelance/core/constants/styles/text_styles.dart';

extension BuildContextExtension on BuildContext {
  AppTextStyles get styles => Theme.of(this).extension<AppTextStyles>()!;
  ThemeData get theme => Theme.of(this);
}
