import 'package:flutter/material.dart';
import 'package:macaw/controller/root_controller.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/view/root_view.dart';

class RootState extends State<RootController> {

	RootView _view = RootView();

	@override
	Widget build(BuildContext context) {
		this._prepareState();
		DataManager.loadData(context);

		return this._view.getView(context);
	}

	void _prepareState() {
		if(!MacawStateManagement.rootStateManaged) {
			MacawStateManagement.appViewFragmentStateChangeCallback = this._appViewFragmentStateChange;
			MacawStateManagement.rootStateManaged = true;
		}
	}

	void _appViewFragmentStateChange(int fragmentCode) {
		setState(() {
			MacawStateManagement.currentViewFragment = fragmentCode;
		});
	}
}