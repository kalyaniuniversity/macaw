import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/service/widget_service.dart';
import 'package:macaw/widget/covid_india_widget_store.dart';
import 'package:macaw/widget/covid_world_widget_store.dart';
import 'package:macaw/widget/macaw_bottom_navigation_item.dart';

class RootWidgetStore {

	static final List _extraOptionsTexts = [
		"Datasets",
		"News",
		"About",
		"How You Can Help"
	];

	static final List<MacawBottomNavigationItem> _bottomNavigationItems = [
		MacawBottomNavigationItem(SwanIcons.india, Constant.INDIA),
		MacawBottomNavigationItem(SwanIcons.globe, Constant.WORLD)
	];

	CovidIndiaWidgetStore _covidIndiaWidgetStore = CovidIndiaWidgetStore();
	CovidWorldWidgetStore _covidWorldWidgetStore = CovidWorldWidgetStore();
	WidgetService _widgetService = WidgetService();

	Widget buildMacawViewFragment(BuildContext context) {

		switch(MacawStateManagement.currentViewFragment) {
			case Constant.VIEW_FRAGMENT_COVID_INDIA: return this._covidIndiaWidgetStore.getView(context);
			case Constant.VIEW_FRAGMENT_COVID_WORLD: return this._covidWorldWidgetStore.getView(context);

			default: return null;
		}
	}

	Widget getFloatingActionButton() {
		return FloatingActionButton(
			child: this._getPopupMenuButton(),
			foregroundColor: Colors.white
		);
	}

	Widget getBottomNavigationBar(BuildContext context) {
		return BottomNavigationBar(
			items:  _widgetService.buildBottomNavigationBarItems(RootWidgetStore._bottomNavigationItems),
			onTap: (index) => this._onBottomNavigationBarItemTapped(context, index),
		);
	}

	Widget _getPopupMenuButton() {
		return PopupMenuButton(
			itemBuilder: (context) => this._widgetService.buildPopupMenu(context, RootWidgetStore._extraOptionsTexts),
			icon: Icon(Icons.menu),
			captureInheritedThemes: true,
			enabled: true,
		);
	}

	void _onBottomNavigationBarItemTapped(BuildContext context, int index) {
		MacawStateManagement.appViewFragmentStateChangeCallback(index);
	}
}