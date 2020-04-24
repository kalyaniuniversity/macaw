import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/view/i_macaw_view.dart';
import 'package:macaw/widget/root_widget_store.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RootView implements IMacawView {

	RootWidgetStore _widgetStore = RootWidgetStore();
	RefreshController _pulldownRefreshController = RefreshController(initialRefresh: false);

	@override
	Widget getView(BuildContext context) {

		return Scaffold(
			key: MacawStateManagement.rootScaffoldKey,
			bottomNavigationBar: _widgetStore.getBottomNavigationBar(context),
			body: SmartRefresher(
				enablePullDown: true,
				enablePullUp: false,
				header: MaterialClassicHeader(
					color: MacawPalette.accentColor,
				),
				controller: _pulldownRefreshController,
				onRefresh: () => _onPullDownRefresh(context),
				onLoading: _onPullDownLoading,
				child: _widgetStore.buildMacawViewFragment(context)
			),
		);
	}

	void _onPullDownRefresh(BuildContext context) async {

		if(!MacawStateManagement.rootStateManaged || !MacawStateManagement.isInitialDataLoaded) return;

		await DataManager.refreshData(context);
		_pulldownRefreshController.refreshCompleted();
	}

	void _onPullDownLoading() async {
		_pulldownRefreshController.loadComplete();
	}
}