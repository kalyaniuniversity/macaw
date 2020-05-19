import 'dart:io';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:macaw/model/coordinate.dart';
import 'package:macaw/model/country.dart';
import 'package:macaw/model/covid_data.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/model/province.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/macaw_state_management.dart';

class CovidMapWidgetStore {

	Animation<double> _fabAnimation;
	AnimationController _fabAnimationController;
	CurvedAnimation _fabCurvedAnimation;

	Widget getMap(BuildContext context, MapOptions mapOptions, MapController mapController, int mapData) {
		return FlutterMap(
			options: mapOptions,
			mapController: mapController,
			layers: this._buildLayerOptions(context, mapData),
		);
	}

	Widget getFloatingActionButton(BuildContext context, List<Bubble> fabItems) {
		return FloatingActionBubble(
			items: fabItems,
			animation: this._getFabAnimation(context),
			onPress: () {
				this._fabAnimationController.isCompleted ? this._fabAnimationController.reverse() : this._fabAnimationController.forward();
			},
			icon: AnimatedIcons.menu_close,
			iconColor: Colors.white,
		);
	}

	Bubble buildWorldMapOption(Function onPressCallback) {
		return Bubble(
			title: Constant.WORLD_MAP,
			icon: SwanIcons.globe,
			iconColor: MacawPalette.darkYellow,
			bubbleColor: Colors.white,
			titleStyle: this._getOptionTextStyle(),
			onPress: () {
				this._fabAnimationController.reverse();
				onPressCallback();
			}
		);
	}

	Bubble buildIndiaMapOption(Function onPressCallback) {
		return Bubble(
			title: Constant.INDIAN_MAP,
			icon: SwanIcons.india,
			iconColor: MacawPalette.darkYellow,
			bubbleColor: Colors.white,
			titleStyle: this._getOptionTextStyle(),
			onPress: () {
				this._fabAnimationController.reverse();
				onPressCallback();
			}
		);
	}

	Bubble buildGoBackOption(BuildContext context) {
		return Bubble(
			title: Constant.GO_BACK,
			icon: Icons.keyboard_arrow_left,
			iconColor: MacawPalette.redTintA,
			bubbleColor: Colors.white,
			titleStyle: this._getOptionTextStyle(),
			onPress: () {
				Navigator.pop(context);
			}
		);
	}

	TextStyle _getOptionTextStyle() {
		return GoogleFonts.changa(
			textStyle: TextStyle(
				fontSize: 16,
				color: MacawPalette.darkBlue
			)
		);
	}

	Animation<double> _getFabAnimation(BuildContext context) {

		this._fabAnimationController = AnimationController(
			vsync: Scaffold.of(context),
			duration: Duration(milliseconds: 260)
		);

		this._fabCurvedAnimation = CurvedAnimation(
			curve: Curves.decelerate,
			parent: this._fabAnimationController
		);

		this._fabAnimation = Tween<double>(
			begin: 0,
			end: 1
		).animate(this._fabCurvedAnimation);

		return this._fabAnimation;
	}

	List<LayerOptions> _buildLayerOptions(BuildContext context, int mapData) {
		return [
			TileLayerOptions(
				urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
				subdomains: ['a', 'b', 'c'],
				tileProvider: CachedNetworkTileProvider()
			),
			MarkerLayerOptions(markers: this._buildMarkers(context, mapData))
		];
	}

	List<Marker> _buildMarkers(BuildContext context, int mapData) {

		List<Marker> markers = List<Marker>();

		CovidData _indiaConfirmed = DataManager.covidIndiaConfirmed;
		CovidData _indiaRecovered = DataManager.covidIndiaRecovered;
		CovidData _indiaDeceased = DataManager.covidIndiaDeceased;

		CovidData _worldConfirmed = DataManager.covidWorldConfirmed;
		CovidData _worldRecovered = DataManager.covidWorldRecovered;
		CovidData _worldDeceased = DataManager.covidWorldDeceased;

		switch(mapData) {

			case Constant.INDIA_MAP_DATA:

				 for(int i = 0; i < _indiaConfirmed.countries[0].provinces.length; i++)
					 markers.add(this._buildMarker(
						 context,
						 _indiaConfirmed.countries[0].provinces[i].getNameLabel(),
						 double.parse(_indiaConfirmed.countries[0].provinces[i].coordinate.latitude),
						 double.parse(_indiaConfirmed.countries[0].provinces[i].coordinate.longitude),
						 _indiaConfirmed.countries[0].provinces[i].lastTimeseries.value,
						 _indiaRecovered.countries[0].provinces[i].lastTimeseries.value,
						 _indiaDeceased.countries[0].provinces[i].lastTimeseries.value
					 ));

				 break;

			case Constant.WORLD_MAP_DATA:

				for(int i = 0; i < _worldConfirmed.countries.length; i++) {

					Country cCountry = _worldConfirmed.countries[i];
					Country rCountry = _worldRecovered.getCountryByName(cCountry.name);
					Country dCountry = _worldDeceased.getCountryByName(cCountry.name);
					Coordinate coordinates = cCountry.getAverageCoordinates();

					markers.add(this._buildMarker(
						context,
						cCountry.name,
						double.parse(coordinates.latitude),
						double.parse(coordinates.longitude),
						cCountry.totalAffected(),
						rCountry.totalAffected(),
						dCountry.totalAffected()
					));
				}

				break;
		}

		return markers;
	}

	Marker _buildMarker(BuildContext context, String name, double latitude, double longitude, double confirmed, double recovered, double deceased) {
		return Marker(
			point: LatLng(latitude, longitude),
			builder: (ctx) => InkWell(
				child: Container(
					child: Icon(
						Icons.location_on,
						color: MacawPalette.darkYellow,
						size: 40.0,
					),
				),
				onTap: () {
					Scaffold.of(context).showSnackBar(
						this._showInfoSnackBar(context, name, confirmed, recovered, deceased)
					);
				},
			),
		);
	}
	
	SnackBar _showInfoSnackBar(BuildContext context, String name, double confirmed, double recovered, double deceased) {
		return SnackBar(
			elevation: 5.0,
			duration: Duration(seconds: 12),
			backgroundColor: MacawPalette.darkBlue,
			behavior: SnackBarBehavior.floating,
			content: this._buildSnackBarMessage(name, confirmed, recovered, deceased),
			action: SnackBarAction(
				label: Constant.OKAY,
				onPressed: () {
					Scaffold.of(context).hideCurrentSnackBar();
				}
			),
		);
	}

	RichText _buildSnackBarMessage(String name, double confirmed, double recovered, double deceased) {
		return RichText(
			text: TextSpan(
				children: <TextSpan>[
					TextSpan(
						text: name.toUpperCase() + "\n",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: MacawPalette.accentColor,
								fontSize: 18.0,
								fontWeight: FontWeight.bold
							)
						)
					),
					TextSpan(
						text: "CONFIRMED: ",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: Colors.white,
								fontSize: 11.0,
							)
						)
					),
					TextSpan(
						text: confirmed.toString() + "\n",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: MacawPalette.accentColor,
								fontSize: 16.0,
								fontWeight: FontWeight.bold
							)
						)
					),
					TextSpan(
						text: "RECOVERED: ",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: Colors.white,
								fontSize: 11.0,
							)
						)
					),
					TextSpan(
						text: recovered.toString() + "\n",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: MacawPalette.green,
								fontSize: 16.0,
								fontWeight: FontWeight.bold
							)
						)
					),
					TextSpan(
						text: "DECEASED: ",
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: Colors.white,
								fontSize: 11.0,
							)
						)
					),
					TextSpan(
						text: deceased.toString(),
						style: GoogleFonts.changa(
							textStyle: TextStyle(
								color: MacawPalette.mudGold,
								fontSize: 16.0,
								fontWeight: FontWeight.bold
							)
						)
					),
				]
			),
		);
	}
}