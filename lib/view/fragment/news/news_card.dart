import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/model/news.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {

	final News news;

	const NewsCard({ Key key, @required this.news }): super(key: key);

	@override
	Widget build(BuildContext context) {
		return Card(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					ListTile(
						contentPadding: EdgeInsets.all(10.0),
						leading: SvgPicture.asset(
							"assets/images/newspaper.svg",
							height: 30.0,
						),
						title: Text(
							this.news.heading,
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									height: 1.5
								)
							),
						),
						subtitle: Text(
							this.news.description,
							style: GoogleFonts.changa(),
						),
						dense: true,
						onTap: () async {
							if(await canLaunch(news.source))
								await launch(news.source);
						},
					),
					Column(
						crossAxisAlignment: CrossAxisAlignment.end,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget> [
							Text(
								this.news.type,
								style: GoogleFonts.changa(
									textStyle: TextStyle(
										fontSize: 12,
										color: MacawPalette.accentColor
									)
								),
							)
						]
					)
				],
			),
		);
	}
}