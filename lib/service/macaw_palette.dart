import 'package:flutter/material.dart';

class MacawPalette {

	static const int _colorDarkBlue = 0xff222831;
	static const int _colorBlueGrey = 0xff30475e;
	static const int _colorDarkYellow = 0xFFF9A825;
	static const int _colorGreystone = 0xFF90A4AE;
	static const int _colorViolet = 0xFFBF05F2;
	static const int _colorGreen = 0xFF168039;
	static const int _colorMudGold = 0xFF8C814A;
	static const int _colorWatermelonRed = 0xFFFE7f9C;

	static const int _greyTint1 = 0xFFFf1F1F1;
	static const int _greyTint2 = 0xFFEDEDED;
	static const int _greyTint3 = 0xFFE4E4E4;
	static const int _greyTint4 = 0xFF7E7E7E;

	static const int _redTint1 = 0xFFFF4000;
	static const int _redTint2 = 0xFFCC0000;
	static const int _redTint3 = 0xFF850000;

	static const Color primaryColor = const Color(MacawPalette._colorGreystone);
	static const Color accentColor = const Color(MacawPalette._colorWatermelonRed);

	static const Color darkBlue = const Color(MacawPalette._colorDarkBlue);
	static const Color green = const Color(MacawPalette._colorGreen);
	static const Color mudGold = const Color(MacawPalette._colorMudGold);

	static const Color greyTintA = const Color(MacawPalette._greyTint1);
	static const Color greyTintB = const Color(MacawPalette._greyTint2);
	static const Color greyTintC = const Color(MacawPalette._greyTint3);
	static const Color greyTintD = const Color(MacawPalette._greyTint4);

	static const Color redTintA = const Color(MacawPalette._redTint1);
	static const Color redTintB = const Color(MacawPalette._redTint2);
	static const Color redTintC = const Color(MacawPalette._redTint3);

	static const Map<int, Color> _swatch = {
		50: MacawPalette.accentColor, // unknown
		100: MacawPalette.accentColor, // accent
		200: MacawPalette.accentColor, // accent
		300: MacawPalette.accentColor, // unknown
		400: MacawPalette.accentColor, // accent
		500: MacawPalette.primaryColor, // primary
		600: MacawPalette.accentColor, // unknown
		700: MacawPalette.accentColor, // accent
		800: MacawPalette.accentColor, // unknown
		900: MacawPalette.accentColor, // unknown
	};

	static MaterialColor primarySwatch = MaterialColor(MacawPalette._colorGreystone, _swatch);
}