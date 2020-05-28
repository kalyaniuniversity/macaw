import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/widget/quick_info.dart';

class MacawWidgetStore {

	Widget buildQuickInfo(QuickInfo quickInfo, { bool isNeutral = false }) {
		return isNeutral ? this._buildNeutralQuickInfo(quickInfo) : this._buildBiasedQuickInfo(quickInfo);
	}

	Widget buildNoDivider(Color color) {
		return Divider(
			color: color,
			thickness: 0.0,
		);
	}

	Widget buildDivider(Color color) {
		return Divider(
			color: color,
			indent: 30.0,
			endIndent: 30.0,
			thickness: 3.0,
		);
	}

	Widget buildProgressIndicatorWidgetView() {
		return Center(
			child: CupertinoActivityIndicator(),
		);
	}

	Widget buildInfoRowView(List<Widget> widgets) {
		return Row(
			children: <Widget>[
				Expanded(
					child: widgets[0]
				),
				SizedBox(
					width: 8.0
				),
				Expanded(
					child: widgets[1]
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