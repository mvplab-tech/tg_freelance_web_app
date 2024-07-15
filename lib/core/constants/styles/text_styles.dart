// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  // Заголовки
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle headline;
  final TextStyle body;
  final TextStyle callout;
  final TextStyle subheadline1;
  final TextStyle subheadline2;
  final TextStyle footnote;
  final TextStyle caption1;
  final TextStyle caption2;

  AppTextStyles({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.headline,
    required this.body,
    required this.callout,
    required this.subheadline1,
    required this.subheadline2,
    required this.footnote,
    required this.caption1,
    required this.caption2,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? headline,
    TextStyle? body,
    TextStyle? callout,
    TextStyle? subheadline1,
    TextStyle? subheadline2,
    TextStyle? footnote,
    TextStyle? caption1,
    TextStyle? caption2,
  }) {
    return AppTextStyles(
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      callout: callout ?? this.callout,
      subheadline1: subheadline1 ?? this.subheadline1,
      subheadline2: subheadline2 ?? this.subheadline2,
      footnote: footnote ?? this.footnote,
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
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      title3: TextStyle.lerp(title3, other.title3, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      callout: TextStyle.lerp(callout, other.callout, t)!,
      subheadline1: TextStyle.lerp(subheadline1, other.subheadline1, t)!,
      subheadline2: TextStyle.lerp(subheadline2, other.subheadline2, t)!,
      footnote: TextStyle.lerp(footnote, other.footnote, t)!,
      caption1: TextStyle.lerp(caption1, other.caption1, t)!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
    );
  }
}
// /   const AppTextStyles({
//     required this.header1,
//     required this.header2,
//     required this.body1,
//     required this.body2,
//     required this.caption1,
//     required this.caption2,
//   });

//   // Метод copyWith
//   @override
//   AppTextStyles copyWith({
//     TextStyle? header1,
//     TextStyle? header2,
//     TextStyle? body1,
//     TextStyle? body2,
//     TextStyle? caption1,
//     TextStyle? caption2,
//   }) {
//     return AppTextStyles(
//       header1: header1 ?? this.header1,
//       header2: header2 ?? this.header2,
//       body1: body1 ?? this.body1,
//       body2: body2 ?? this.body2,
//       caption1: caption1 ?? this.caption1,
//       caption2: caption2 ?? this.caption2,
//     );
//   }

//   @override
//   AppTextStyles lerp(
//     covariant ThemeExtension<AppTextStyles>? other,
//     double t,
//   ) {
//     if (other == null || other is! AppTextStyles) {
//       return this;
//     }

//     return AppTextStyles(
//       header1: TextStyle.lerp(header1, other.header1, t)!,
//       header2: TextStyle.lerp(header2, other.header2, t)!,
//       body1: TextStyle.lerp(body1, other.body1, t)!,
//       body2: TextStyle.lerp(body2, other.body2, t)!,
//       caption1: TextStyle.lerp(caption1, other.caption1, t)!,
//       caption2: TextStyle.lerp(caption2, other.caption2, t)!,
//     );
//   }

//   // Метод lerp
//   // @override
//   //  AppTextStyles lerp(AppTextStyles a, AppTextStyles b, double t) {

//   // }
// }

// Определение базовых стилей текста
final appTextStyles = AppTextStyles(
  title1: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 34 / 28),
  title2: const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 28 / 22),
  title3: const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 24 / 20),
  headline: const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 22 / 17),
  body: const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 22 / 17),
  callout: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 22 / 16),
  subheadline1: const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 18 / 15),
  subheadline2: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 18 / 14),
  footnote: const TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 18 / 13),
  caption1: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 16 / 12),
  caption2: const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
      color: Colors.black,
      height: 13 / 11),
);
