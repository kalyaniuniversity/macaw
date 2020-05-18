import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';

class MacawDefaultNetworkErrorDialog extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return AlertDialog(
			title: Text(
				"Oops 😵",
				style: GoogleFonts.roboto(
					textStyle: TextStyle(
						color: MacawPalette.redTintB,
						fontSize: 40.0,
						fontWeight: FontWeight.w200
					)
				)
			),
			content: SingleChildScrollView(
				child: ListBody(
					children: <Widget>[
						Text(
							Constant.NETWORK_FAILURE_MESSAGE,
							style: GoogleFonts.robotoMono(
								textStyle: TextStyle(
									fontSize: 13.0
								)
							)
						)
					],
				)
			),
			actions: <Widget>[
				FlatButton(
					child: Text("Okay"),
					onPressed: () {
						Navigator.of(context).pop();
					},
				)
			],
		);
	}
}