import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macaw/view/i_macaw_view.dart';
import 'package:macaw/widget/root_widget_store.dart';

class RootView implements IMacawView {

	RootWidgetStore _widgetStore = RootWidgetStore();

	@override
	Widget getView(BuildContext context) {
		return Scaffold(
			body: _widgetStore.buildMacawViewFragment(context),
			floatingActionButton: _widgetStore.getFloatingActionButton(),
			floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
			bottomNavigationBar: _widgetStore.getBottomNavigationBar(context),
		);
	}
}