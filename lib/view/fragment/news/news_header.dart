import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/service/macaw_palette.dart';

class NewsHeader extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.end,
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget> [
				Text(
					"News",
					style: GoogleFonts.changa(
						textStyle: TextStyle(
							fontSize: 30,
							color: MacawPalette.greyTintD
						)
					),
				)
			]
		);
	}
}