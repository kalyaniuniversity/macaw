import 'package:macaw/service/subscriber.dart';

class DataSubscription {

	static final Subscriber indiaLatestDateSubscription = Subscriber({'date': '-'});
	static final Subscriber worldLatestDateSubscription = Subscriber({'date': '-'});

	static void renewIndiaLatestDate(String date) {
		DataSubscription.indiaLatestDateSubscription.setDataByKey('date', date);
		if(DataSubscription.indiaLatestDateSubscription.callback != null) DataSubscription.indiaLatestDateSubscription.callback(date);
	}

	static void renewWorldLatestDate(String date) {
		DataSubscription.worldLatestDateSubscription.setDataByKey('date', date);
		if(DataSubscription.worldLatestDateSubscription.callback != null) DataSubscription.worldLatestDateSubscription.callback(date);
	}
}