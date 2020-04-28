import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/macaw_state_management.dart';

class MacawNetworkErrorAlertDialog extends StatelessWidget {

	final String _message;
	final BuildContext _callerContext;

	MacawNetworkErrorAlertDialog(this._callerContext, this._message);

	@override
	Widget build(BuildContext context) {
		return AlertDialog(
			title: Text(
				"Oops! 🤕",
				style: GoogleFonts.roboto(
					textStyle: TextStyle(
						color: MacawPalette.redTintB,
						fontSize: 40.0,
						fontWeight: FontWeight.w200
					)
				),
			),
			content: SingleChildScrollView(
				child: ListBody(
					children: <Widget>[
						Container(
							padding: const EdgeInsets.all(4.0),
							decoration: BoxDecoration(
								color: MacawPalette.greyTintC
							),
							child: Text(
								Constant.NETWORK_FAILURE_MESSAGE_SHORT,
								style: GoogleFonts.robotoMono(
									textStyle: TextStyle(
										fontSize: 11.0
									)
								),
							)
						),
						Container(
							padding: const EdgeInsets.only(
								left: 4.0,
								right: 4.0,
								bottom: 4.0,
								top: 10.0
							),
							margin: const EdgeInsets.only(
								top: 10.0
							),
							child: Text(
								this._message,
								style: GoogleFonts.roboto(
									textStyle: TextStyle(
										fontSize: 14.0
									)
								),
							)
						)
					],
				),
			),
			actions: <Widget>[
				FlatButton(
					child: Text(Constant.TRY_AGAIN),
					onPressed: () {
						MacawStateManagement.isInitialDataLoaded = true;
						Navigator.of(context).pop();
						DataManager.loadData(this._callerContext);
					},
				),
				FlatButton(
					child: Text(Constant.DISMISS),
					onPressed: () {
						Navigator.of(context).pop();
					},
				)
			],
		);
	}
}