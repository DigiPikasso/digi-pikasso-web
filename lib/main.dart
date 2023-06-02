import 'package:digi_pikasso/di/locator.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  setPathUrlStrategy();
  setupLocator();
  runApp(const MyApp());
}
