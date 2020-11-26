import 'package:flutter/material.dart';

// Colors that we use in our app

const kSecondaryColor = Color(0xFF3bb4b7);
const kPrimaryColor = Color(0xFF3a7578);
const kBackgroundColor = Color(0xFFF9F8FD);
const kTextColor = Color(0xFFbdbdbd);

const double kDefaultPaddingHorizontal = 20.0;
const double kDefaultPaddingVertical = 10.0;

const TextStyle kTitleTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubTitleTextStyle = TextStyle(
  color: Color(0xFF8f8f90),
  fontWeight: FontWeight.w500,
);
enum DateRange {
  LastWeek,
  ThisWeek,
  LastMonth,
  ThisMonth,
  LastQuarter,
  ThisQuarter,
}
