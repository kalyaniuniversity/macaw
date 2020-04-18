import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/widget/quick_info.dart';
import 'package:macaw/widget/quick_info_style.dart';

class MacawWidgetStore {

	Widget buildFragmentHeader(String title) {
		return Container(
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.end,
				mainAxisAlignment: MainAxisAlignment.end,
				children: <Widget>[
					Text(
						title,
						style: GoogleFonts.bebasNeue(
							textStyle: TextStyle(
								color: MacawPalette.accentColor,
								fontSize: 45.0,
								fontWeight: FontWeight.bold,
								letterSpacing: 4.0,
							)
						),
					)
				],
			)
		);
	}

	Widget buildQuickInfo(QuickInfo quickInfo, { bool isNeutral = false }) {
		return isNeutral ? this._buildNeutralQuickInfo(quickInfo) : this._buildBiasedQuickInfo(quickInfo);
	}

	Widget buildDefaultNetworkErrorDialog(BuildContext context) {
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

	Widget buildNetworkErrorAlertDialog(BuildContext context, BuildContext callerContext, String message) {
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
								message,
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
						Navigator.of(context).pop();
						DataManager.loadData(callerContext);
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

	Widget _buildNeutralQuickInfo(QuickInfo quickInfo) {
		return Container(
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Container(
						child: this._buildQuickInfoTitle(quickInfo.title),
					),
					Container(
						child: this._buildQuickInfoValue(quickInfo.value, quickInfo.style),
					),
					Container(
						child: Text(
							quickInfo.extraInfo,
							style: GoogleFonts.robotoMono(
								textStyle: quickInfo.extraInfoStyle
							)
						)
					)
				],
			),
			padding: const EdgeInsets.all(4.0),
			margin: const EdgeInsets.all(2.0)
		);
	}

	Widget _buildBiasedQuickInfo(QuickInfo quickInfo) {
		return Container(
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Container(
						child: this._buildQuickInfoTitle(quickInfo.title),
					),
					Container(
						child: this._buildQuickInfoValue(quickInfo.value, quickInfo.style),
					),
					Container(
						child: Text(
							quickInfo.extraInfo,
							style: GoogleFonts.robotoMono(
								textStyle: quickInfo.extraInfoStyle
							),
						)
					),
					Container(
						margin: const EdgeInsets.only(
							top: 6.0
						),
						child: Text(quickInfo.emoji)
					)
				],
			),
			padding: const EdgeInsets.all(4.0),
			margin: const EdgeInsets.all(2.0)
		);
	}
	
	Widget _buildQuickInfoTitle(String title) {
		return Text(
			title + ":",
			style: GoogleFonts.roboto(
				textStyle: TextStyle(
					color: MacawPalette.greyTintD,
					fontSize: 15.0,
					fontWeight: FontWeight.bold,
					letterSpacing: 1.0,
				)
			)
		);
	}

	Widget _buildQuickInfoValue(String value, TextStyle textStyle) {
		return Text(
			value,
			style: GoogleFonts.robotoMono(
				textStyle: textStyle
			)
		);
	}
}