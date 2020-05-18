import 'dart:io';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:macaw/controller/covid_map_controller.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/widget/covid_map_widget_store.dart';
import 'package:latlong/latlong.dart';

class MapState extends State<CovidMapController> with TickerProviderStateMixin {

	CovidMapWidgetStore _mapWidgetStore = CovidMapWidgetStore();
	MapController _mapController = MapController();
	LatLng _center = LatLng(20.5937, 78.9629);

	MapOptions _mapOptions;

	@override
	void initState() {
		super.initState();
		this._mapOptions = MapOptions(
			center: this._center,
			zoom: 5.0
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: this._mapWidgetStore.getMap(this._mapOptions, this._mapController),
			floatingActionButton: Builder(
				builder: (ctx) => this._mapWidgetStore.getFloatingActionButton(ctx, this._getFabItems(ctx)),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
		);
	}

	List<Bubble> _getFabItems(BuildContext context) {

		List<Bubble> items = [
			this._mapWidgetStore.buildWorldMapOption(this._showWorldMap),
			this._mapWidgetStore.buildIndiaMapOption(this._showIndianMap)
		];

		if(Platform.isIOS)
			items.add(this._mapWidgetStore.buildGoBackOption(context));

		return items;
	}

	void _showWorldMap() {
		this._animatedMapMove(this._center, 2);
	}

	void _showIndianMap() {
		this._animatedMapMove(this._center, 5);
	}

	void _animatedMapMove(LatLng destination, double zoom) {

		final _latTween = Tween<double>(
			begin: this._mapController.center.latitude,
			end: destination.latitude
		);

		final _lngTween = Tween<double>(
			begin: this._mapController.center.longitude,
			end: destination.longitude
		);

		final _zoomTween = Tween<double>(
			begin: this._mapController.zoom,
			end: zoom
		);
		
		AnimationController _animationController = AnimationController(
			vsync: this,
			duration: const Duration(
				milliseconds: 500
			)
		);

		Animation<double> animation = CurvedAnimation(
			parent: _animationController,
			curve: Curves.fastOutSlowIn
		);
		
		_animationController.addListener(() {
			this._mapController.move(
				LatLng(
					_latTween.evaluate(animation),
					_lngTween.evaluate(animation)
				),
				_zoomTween.evaluate(animation)
			);
		});

		animation.addStatusListener((status) {
			if(status == AnimationStatus.completed)
				_animationController.dispose();
			else if(status == AnimationStatus.dismissed)
				_animationController.dispose();
		});

		_animationController.forward();
	}
}