import 'package:flutter/material.dart';
import 'package:macaw/service/macaw_palette.dart';

class MacawTheme {

	static ThemeData primaryTheme = new ThemeData(
		accentColor: MacawPalette.accentColor,
		primaryColor: MacawPalette.primaryColor,
		primarySwatch: MacawPalette.primarySwatch
	);
}