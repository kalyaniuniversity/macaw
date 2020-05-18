import 'dart:io';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';

class CovidMapWidgetStore {

	Animation<double> _fabAnimation;
	AnimationController _fabAnimationController;
	CurvedAnimation _fabCurvedAnimation;

	Widget getMap(MapOptions mapOptions, MapController mapController) {
		return FlutterMap(
			options: mapOptions,
			mapController: mapController,
			layers: this._buildLayerOptions(),
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

	List<LayerOptions> _buildLayerOptions() {
		return [
			TileLayerOptions(
				urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
				subdomains: ['a', 'b', 'c'],
				tileProvider: CachedNetworkTileProvider()
			)
		];
	}
}