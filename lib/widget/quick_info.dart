import 'package:flutter/material.dart';

class QuickInfo {

	String _title;
	String _value;
	String _emoji;
	String _extraInfo;
	TextStyle _style;
	TextStyle _extraInfoStyle;

	QuickInfo(this._title, this._value, this._emoji, this._extraInfo, this._style, this._extraInfoStyle);

	String get title => this._title;
	String get value => this._value;
	String get emoji => this._emoji;
	String get extraInfo => this._extraInfo;
	TextStyle get style => this._style;
	TextStyle get extraInfoStyle => this._extraInfoStyle;

}