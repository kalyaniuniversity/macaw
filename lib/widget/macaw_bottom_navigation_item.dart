import 'package:flutter/cupertino.dart';

class MacawBottomNavigationItem {

	IconData _iconData;
	String _title;

	MacawBottomNavigationItem(this._iconData, this._title);

	IconData getIconData() {
		return this._iconData;
	}

	String getTitle() {
		return this._title;
	}
}