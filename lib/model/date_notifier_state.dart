import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/controller/date_notifier_controller.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/subscriber.dart';
import 'package:macaw/view/date_notifier_view.dart';

class DateNotifierState extends State<DateNotifierController> {

	final DateNotifierView _view = DateNotifierView();
	final Subscriber _subscriber;

	DateNotifierState(this._subscriber);

	@override
	Widget build(BuildContext context) {
		return this._view.getView(context);
	}

	@override
	void initState() {

		super.initState();

		this._subscriber.callback = this._updateDate;
		this._view.date = this._subscriber.getStringDataByKey('date');
	}

	@override
	void dispose() {
		super.dispose();
	}

	void _updateDate(String date) {
		setState(() {
			this._view.date = date;
			this._subscriber.setDataByKey('date', date);
		});
	}
}