import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  // Заголовки
  final TextStyle header1;
  final TextStyle header2;

  // Основной текст
  final TextStyle body1;
  final TextStyle body2;

  // Подписи
  final TextStyle caption1;
  final TextStyle caption2;

  const AppTextStyles({
    required this.header1,
    required this.header2,
    required this.body1,
    required this.body2,
    required this.caption1,
    required this.caption2,
  });

  // Метод copyWith
  @override
  AppTextStyles copyWith({
    TextStyle? header1,
    TextStyle? header2,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? caption1,
    TextStyle? caption2,
  }) {
    return AppTextStyles(
      header1: header1 ?? this.header1,
      header2: header2 ?? this.header2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
    );
  }

  @override
  AppTextStyles lerp(
    covariant ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    if (other == null || other is! AppTextStyles) {
      return this;
    }

    return AppTextStyles(
      header1: TextStyle.lerp(header1, other.header1, t)!,
      header2: TextStyle.lerp(header2, other.header2, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      caption1: TextStyle.lerp(caption1, other.caption1, t)!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
    );
  }

  // Метод lerp
  // @override
  //  AppTextStyles lerp(AppTextStyles a, AppTextStyles b, double t) {

  // }
}

// Определение базовых стилей текста
const appTextStyles = AppTextStyles(
    header1: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
    ),
    header2: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
    caption1: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
    ),
    caption2: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.normal,
      // color: Colors.grey,
    ));
