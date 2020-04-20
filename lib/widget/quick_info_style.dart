import 'package:flutter/material.dart';
import 'package:macaw/service/macaw_palette.dart';

class QuickInfoStyle {

	static const TextStyle neutralStyle = TextStyle(
		color: Colors.black54,
		fontSize: 20.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle positiveStyle = TextStyle(
		color: MacawPalette.green,
		fontSize: 28.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle positiveStyleSmallFont = TextStyle(
		color: MacawPalette.green,
		fontSize: 21.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle warningStyle = TextStyle(
		color: MacawPalette.redTintB,
		fontSize: 28.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle warningStyleSmallFont = TextStyle(
		color: MacawPalette.redTintB,
		fontSize: 21.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle dangerStyle = TextStyle(
		color: MacawPalette.mudGold,
		fontSize: 28.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle dangerStyleSmallFont = TextStyle(
		color: MacawPalette.mudGold,
		fontSize: 21.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle positiveExtraInfo = TextStyle(
		color: MacawPalette.green,
		fontSize: 15.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle warningExtraInfo = TextStyle(
		color: MacawPalette.redTintB,
		fontSize: 15.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle dangerExtraInfo = TextStyle(
		color: MacawPalette.mudGold,
		fontSize: 15.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);

	static const TextStyle neutralExtraInfo = TextStyle(
		color: MacawPalette.darkBlue,
		fontSize: 15.0,
		fontWeight: FontWeight.bold,
		letterSpacing: 1.0,
		height: 2.0
	);
}