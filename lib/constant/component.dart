import 'package:flutter/material.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/constant/typography.dart';

InputDecoration kDecorationForm = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  hintStyle: TStyle.titleLight.copyWith(fontSize: 15, color: kColorNeutral50),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: kColorBlue)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: kColorNeutral50, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(
      color: kColorRed,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(
      color: kColorRed,
    ),
  ),
);
