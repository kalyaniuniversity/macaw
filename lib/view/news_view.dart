import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/service/macaw_palette.dart';

class NewsView extends StatefulWidget {

	NewsView({ Key key }): super(key: key);

	@override
	NewsState createState() => NewsState();
}

class NewsState extends State<NewsView> {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			floatingActionButton: FloatingActionButton.extended(
				backgroundColor: MacawPalette.roseannaGradientEnd,
				label: Text(
					'go back',
					style: GoogleFonts.changa(),
				),
				icon: Icon(Icons.keyboard_arrow_left),
				foregroundColor: MacawPalette.greyTintD,
				onPressed: () {
					Navigator.pop(context);
				},
			),
		);
	}
}