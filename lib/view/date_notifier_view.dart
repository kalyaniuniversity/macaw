import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/view/i_macaw_view.dart';

class DateNotifierView implements IMacawView {

	String _date;

	set date(String date) => this._date = date;

	@override
	Widget getView(BuildContext context) {
		return Container(
			alignment: Alignment.center,
			margin: const EdgeInsets.only(
				left: 4.0,
				right: 4.0
			),
			padding: const EdgeInsets.all(8.0),
			decoration: BoxDecoration(

			),
			child: RichText(
				text: TextSpan(
					children: <TextSpan>[
						TextSpan(
							text: "AS OF ",
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									color: Colors.black54,
									fontSize: 14.0,
								)
							)
						),
						TextSpan(
							text: this._date,
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									color: MacawPalette.accentColor,
									fontSize: 16.0,
									fontWeight: FontWeight.bold
								)
							)
						),
						TextSpan(
							text: " (MM/DD/YYYY)",
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									color: Colors.black54,
									fontSize: 14.0
								)
							)
						)
					]
				),
			),
		);
	}
}