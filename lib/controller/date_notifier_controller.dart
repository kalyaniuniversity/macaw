import 'package:flutter/material.dart';
import 'package:macaw/model/date_notifier_state.dart';
import 'package:macaw/service/subscriber.dart';

class DateNotifierController extends StatefulWidget {

	final Subscriber subscriber;

	DateNotifierController({
		Key key,
		@required this.subscriber
	}): assert(subscriber != null),  super(key: key);

	@override
	DateNotifierState createState() {
		return DateNotifierState(this.subscriber);
	}
}