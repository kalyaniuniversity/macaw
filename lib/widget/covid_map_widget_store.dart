import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class CovidMapWidgetStore {

	Widget getView(BuildContext context) {

		return FlutterMap(
			options: MapOptions(
				center: LatLng(20.5937, 78.9629),
//				center: LatLng(51.5, -0.09),
				zoom: 5.0
			),
			layers: [
				TileLayerOptions(
					urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
					subdomains: ['a', 'b', 'c'],
					tileProvider: CachedNetworkTileProvider()
				)
			],
		);
	}
}