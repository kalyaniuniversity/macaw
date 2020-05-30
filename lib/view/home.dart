import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/widget/macaw_bottom_navigation_item.dart';

class Home extends StatefulWidget {

	Home({ Key key }): super(key: key);

	@override
	HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

	static final List<MacawBottomNavigationItem> _bottomNavigationItems = [
		MacawBottomNavigationItem(SwanIcons.india, Constant.INDIA),
		MacawBottomNavigationItem(SwanIcons.globe, Constant.WORLD),
		MacawBottomNavigationItem(Icons.location_on, Constant.MAP)
	];

	static final List _extraOptionsTexts = [
		"Datasets",
		"News",
		"About",
		"How You Can Help",
		"Refresh"
	];

	static int _currentViewIndex = 0;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			bottomNavigationBar: this._buildBottomNavigationBar(context),
		);
	}

	Widget _buildBottomNavigationBar(BuildContext context) {
		return BottomNavigationBar(
			items: this.buildBottomNavigationBarItems(context),
			selectedItemColor: MacawPalette.darkYellow,
			unselectedItemColor: MacawPalette.primaryColor,
			currentIndex: HomeState._currentViewIndex,
			showSelectedLabels: true,
			showUnselectedLabels: true,
			type: BottomNavigationBarType.fixed,
			onTap: (index) => this._onBottomNavigationBarItemTapped(context, index),
		);
	}

	List<BottomNavigationBarItem> buildBottomNavigationBarItems(BuildContext context) {

		List<BottomNavigationBarItem> navigationItems = List<BottomNavigationBarItem>();

		HomeState._bottomNavigationItems.forEach((item) => [
			navigationItems.add(this._buildBottomNavigationBarItem(item.getIconData(), item.getTitle()))
		]);

		navigationItems.add(this._buildBottomNavigationMoreOptionsItem(context));

		return navigationItems;
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

	List<PopupMenuEntry<int>> _buildPopupMenu(BuildContext context) {

		List<PopupMenuEntry<int>> list = List<PopupMenuEntry<int>>();

		for(int i = 0; i < HomeState._extraOptionsTexts.length; i++) list.add(
			PopupMenuItem(
				child: Text(HomeState._extraOptionsTexts[i]),
				value: i
			)
		);

		return list;
	}

	Future<void> _popupMenuItemSelected(BuildContext context, int index) async {

		if(index == null)
			return;

		switch(index) {
			case 0: Navigator.pushNamed(context, Constant.ROUTE_DATASETS); break;
			case 1: Navigator.pushNamed(context, Constant.ROUTE_NEWS); break;
			case 2: Navigator.pushNamed(context, Constant.ROUTE_ABOUT); break;
//			case 4:
//
//				MacawStateManagement.showLoadingProgressbar = true;
//				await DataManager.refreshData(context);
//				MacawStateManagement.rootScaffoldKey.currentState.showSnackBar(this._buildManualRefreshCompleteSnackBar());
//
//				break;
		}
	}

	void _onBottomNavigationBarItemTapped(BuildContext context, int index) async {

		print(HomeState._currentViewIndex);

		switch(index) {
			case 0:
			case 1: setState(() {
				HomeState._currentViewIndex = index;
			}); break;
//			case 2: Navigator.push(context, MaterialPageRoute(
//				builder: (context) => CovidMapController()
//			)); break;
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
					items: this._buildPopupMenu(context)
				).then((value) => this._popupMenuItemSelected(context, value));

				break;
		}
	}
}