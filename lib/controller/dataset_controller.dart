import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/model/dataset.dart';
import 'package:macaw/model/datasets.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:url_launcher/url_launcher.dart';

class DatasetController extends StatelessWidget {

	@override
	build(BuildContext context) {
		return Scaffold(
			body: ListView.separated(
				separatorBuilder: (context, index) => Divider(
					height: 5,
					color: Colors.white,
				),
				itemCount: Datasets.datasets.length + 1,
				itemBuilder: (context, index) => Padding(
					padding: this._getListItemPadding(index),
					child: this._listViewChildBuilder(index),
				)
			),
		);
	}

	EdgeInsetsGeometry _getListItemPadding(int index) {
		switch(index) {
			case 0: return EdgeInsets.only(top: 150.0, left: 0.0, right: 15.0, bottom: 15.0);
			case 1: return EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0, bottom: 15.0);
			default: return EdgeInsets.all(15.0);
		}
	}

	Widget _listViewChildBuilder(int index) {

		if(index == 0)
			return Column(
				crossAxisAlignment: CrossAxisAlignment.end,
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget> [
					Text(
						"Datasets",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								fontSize: 30,
								color: MacawPalette.greyTintD
							)
						),
					)
				]
			);

		return this._infoCard(Datasets.datasets[index - 1]);
	}

	Widget _infoCard(Dataset dataset) {
		return Card(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					ListTile(
						contentPadding: EdgeInsets.all(10.0),
						leading: Icon(Icons.apps),
						title: Text(
							dataset.title,
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									height: 1.5
								)
							),
						),
						subtitle: Text(
							dataset.subtitle,
							style: GoogleFonts.changa(),
						),
						onTap: () async {
							if(await canLaunch(dataset.url))
								await launch(dataset.url);
						},
					)
				],
			),
		);
	}
}