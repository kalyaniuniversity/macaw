import 'package:flutter/material.dart';

class CovidWorldWidgetStore {

	Widget getView(BuildContext context) {
		return ListView.separated(
			separatorBuilder: (context, index) => Divider(
				color: Colors.black
			),
			itemCount: 3,
			itemBuilder: (context, index) => Padding(
				padding: EdgeInsets.all(18.0),
				child: this._listViewChildBuilder(index)
			),
		);
	}

	Widget _listViewChildBuilder(int index) {
		return Center(
			child: Container(
				height: 50,
				color: Colors.amber[600],
				child: Center(
					child: Text("COVID WORLD $index"),
				),
			)
		);
	}
}