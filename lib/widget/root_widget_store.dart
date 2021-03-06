import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/controller/about_controller.dart';
import 'package:macaw/controller/covid_map_controller.dart';
import 'package:macaw/controller/dataset_controller.dart';
import 'package:macaw/controller/news_controller.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/widget/covid_india_widget_store.dart';
import 'package:macaw/widget/covid_world_widget_store.dart';
import 'package:macaw/widget/macaw_bottom_navigation_item.dart';

class RootWidgetStore {

	static final List _extraOptionsTexts = [
		"Datasets",
		"News",
		"About",
		"How You Can Help",
		"Refresh"
	];

	static final List<MacawBottomNavigationItem> _bottomNavigationItems = [
		MacawBottomNavigationItem(SwanIcons.india, Constant.INDIA),
		MacawBottomNavigationItem(SwanIcons.globe, Constant.WORLD),
		MacawBottomNavigationItem(Icons.location_on, Constant.MAP)
	];

	CovidIndiaWidgetStore _covidIndiaWidgetStore = CovidIndiaWidgetStore();
	CovidWorldWidgetStore _covidWorldWidgetStore = CovidWorldWidgetStore();

	Widget buildMacawViewFragment(BuildContext context) {

		switch(MacawStateManagement.currentViewFragment) {
			case Constant.VIEW_FRAGMENT_COVID_INDIA: return this._covidIndiaWidgetStore.getView(context);
			case Constant.VIEW_FRAGMENT_COVID_WORLD: return this._covidWorldWidgetStore.getView(context);
			default: return null;
		}
	}

	Widget getBottomNavigationBar(BuildContext context) {
		return BottomNavigationBar(
			items:  this.buildBottomNavigationBarItems(context),
			selectedItemColor: MacawPalette.darkYellow,
			unselectedItemColor: MacawPalette.primaryColor,
			currentIndex: MacawStateManagement.currentViewFragment,
			showSelectedLabels: true,
			showUnselectedLabels: true,
			type: BottomNavigationBarType.fixed,
			onTap: (index) => this._onBottomNavigationBarItemTapped(context, index),
		);
	}

	List<BottomNavigationBarItem> buildBottomNavigationBarItems(BuildContext context) {

		List<BottomNavigationBarItem> navigationItems = List<BottomNavigationBarItem>();

		RootWidgetStore._bottomNavigationItems.forEach((item) => [
			navigationItems.add(this._buildBottomNavigationBarItem(item.getIconData(), item.getTitle()))
		]);

		navigationItems.add(this._buildBottomNavigationMoreOptionsItem(context));

		return navigationItems;
	}

	BottomNavigationBarItem _buildBottomNavigationMoreOptionsItem(BuildContext context) {
		return BottomNavigationBarItem(
			icon: Icon(Icons.short_text),
			title: Text(
				Constant.MORE,
				style: GoogleFonts.changa(),
			),
			backgroundColor: MacawPalette.darkYellow
		);
	}

	BottomNavigationBarItem _buildBottomNavigationBarItem(IconData iconData, String title) {
		return BottomNavigationBarItem(
			icon: Icon(iconData),
			title: Text(
				title,
				style: GoogleFonts.changa(),
			),
			backgroundColor: MacawPalette.darkYellow
		);
	}

	List<PopupMenuEntry<int>> buildPopupMenu(BuildContext context) {

		List<PopupMenuEntry<int>> list = List<PopupMenuEntry<int>>();

		for(int i = 0; i < RootWidgetStore._extraOptionsTexts.length; i++) list.add(
			PopupMenuItem(
				child: Text(RootWidgetStore._extraOptionsTexts[i]),
				value: i
			)
		);

		return list;
	}

	Future<void> _popupMenuItemSelected(BuildContext context, int index) async {

		if(index == null)
			return;

		switch(index) {
			case 0: Navigator.push(context, MaterialPageRoute(
				builder: (context) => DatasetController()
			)); break;
			case 1: Navigator.push(context, MaterialPageRoute(
				builder: (context) => NewsController()
			)); break;
			case 2: Navigator.push(context, MaterialPageRoute(
				builder: (context) => AboutController()
			)); break;
			case 4:

				MacawStateManagement.showLoadingProgressbar = true;
				await DataManager.refreshData(context);
				MacawStateManagement.rootScaffoldKey.currentState.showSnackBar(this._buildManualRefreshCompleteSnackBar());

				break;
		}
	}

	void _onBottomNavigationBarItemTapped(BuildContext context, int index) async {

		switch(index) {
			case 0:
			case 1: MacawStateManagement.appViewFragmentStateChangeCallback(index); break;
			case 2: Navigator.push(context, MaterialPageRoute(
				builder: (context) => CovidMapController()
			)); break;
			case 3:

				final RenderBox button = context.findRenderObject();
				final RenderBox overlay = Overlay.of(context).context.findRenderObject();
				final RelativeRect position = RelativeRect.fromRect(
					Rect.fromPoints(
						button.localToGlobal(button.size.bottomCenter(Offset(0, 0)), ancestor: overlay),
						button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay)
					),
					Offset.zero & overlay.size,
				);

				showMenu(
					context: context,
					position: position,
					items: this.buildPopupMenu(context)
				).then((value) => this._popupMenuItemSelected(context, value));

				break;
		}
	}

	SnackBar _buildManualRefreshCompleteSnackBar() {
		return SnackBar(
			elevation: 5.0,
			duration: Duration(seconds: 5),
			backgroundColor: MacawPalette.darkBlue,
			behavior: SnackBarBehavior.floating,
			content: Text(
				Constant.MANUAL_REFRESH_SNACKBAR_MESSAGE,
				style: GoogleFonts.changa(),
			),
			action: SnackBarAction(
				label: Constant.OKAY,
				onPressed: () {
					MacawStateManagement.rootScaffoldKey.currentState.hideCurrentSnackBar();
				}
			),
		);
	}
}