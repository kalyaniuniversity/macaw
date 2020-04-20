import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/widget/macaw_bottom_navigation_item.dart';

class WidgetService {

	List<PopupMenuEntry<Object>> buildPopupMenu(BuildContext context, List options) {

		List<PopupMenuEntry<Object>> list = List<PopupMenuEntry<Object>>();

		for(int i = 0; i < options.length; i++) list.add(
			PopupMenuItem(
				child: Text(options[i]),
				value: i
			)
		);

		return list;
	}

	List<BottomNavigationBarItem> buildBottomNavigationBarItems(List<MacawBottomNavigationItem> items) {

		List<BottomNavigationBarItem> navigationItems = List<BottomNavigationBarItem>();

		items.forEach((item) => [
			navigationItems.add(this._buildBottomNavigationBarItem(item.getIconData(), item.getTitle()))
		]);

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
}