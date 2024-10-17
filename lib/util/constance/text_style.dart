import 'package:flutter/material.dart';
import 'package:k_bus_driver/util/constance/app_colors.dart';

class AppText {
  static TextStyle get standerdSize =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get standerdSizeWhite => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle get smallDark => const TextStyle(
        fontSize: 12,
        color: AppColor.textPrimary,
      );
  static TextStyle get smallGrey => const TextStyle(
        fontSize: 12,
        color: AppColor.grey,
      );
  static TextStyle get smallLight => const TextStyle(
        fontSize: 12,
        color: AppColor.textSecondary,
      );
  static TextStyle get mediumdark => const TextStyle(
        fontSize: 16,
        color: AppColor.secondaryColor,
      );

  static TextStyle get mediumLight => const TextStyle(
        fontSize: 16,
        color: Colors.white,
      );
  static TextStyle get mediumPrimary => const TextStyle(
        fontSize: 16,
        color: AppColor.primaryColor,
      );
  static TextStyle get mediumlightGrey => const TextStyle(
        fontSize: 16,
        color: AppColor.lightGreyColor,
      );
  static TextStyle get mediumGrey => const TextStyle(
        fontSize: 16,
        color: AppColor.grey,
      );
  static TextStyle get largeDark => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColor.secondaryColor,
      );
  static TextStyle get largeLight => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
  static TextStyle get xLarge => const TextStyle(
        fontSize: 39,
        fontWeight: FontWeight.w500,
        color: AppColor.textPrimary,
      );

  static TextStyle get toSmallLineThrough => const TextStyle(
      decoration: TextDecoration.lineThrough,
      decorationColor: Colors.grey,
      color: Colors.grey,
      fontSize: 10,
      overflow: TextOverflow.ellipsis);
}
