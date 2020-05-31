import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/model/news.dart';
import 'package:macaw/service/macaw_palette.dart';

class NewsDateHeader extends StatelessWidget {

	final String date;

	const NewsDateHeader({ Key key, @required this.date }): super(key: key);

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				Container(
					padding: EdgeInsets.only(bottom: 10.0),
					child: SvgPicture.asset(
						"assets/images/calendar.svg",
						height: 20.0,
					),
				),
				Center(
					child: Text(
						this.date,
						style: GoogleFonts.robotoMono(
							textStyle: TextStyle(
								fontWeight: FontWeight.bold,
								fontSize: 16.0,
								letterSpacing: 2.0,
								color: MacawPalette.roseannaGradientStart
							)
						),
					),
				)
			],
		);
	}
}