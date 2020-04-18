import 'package:intl/intl.dart';
import 'package:macaw/model/timeseries.dart';

class Workhorse {

	static final NumberFormat numberFormat = new NumberFormat("##,###");

	static double getNumberFromCommaSeparatedString(String value) {

		String result = "";
		List<String> values = value.split(",");

		values.forEach((v) => result += v);

		return Workhorse.isNumberic(result) ? double.parse(result) : 0;
	}

	static String capitalizeFirstLetter(String value) {

		if(value == null) return value;
		if(value.length < 2) return value.toUpperCase();

		return value[0].toUpperCase() + value.substring(1).toLowerCase();
	}

	static bool isNumberic(String value) {
		return (value == null) ? false : (double.tryParse(value) != null);
	}

	static List<Timeseries> prepareTimeseries(List<dynamic> row, List<String> headers, int startIndex) {

		List<Timeseries> timeseries = [];

		for(int i = startIndex; i < row.length; i++) {
			String date = headers[i];
			timeseries.add(new Timeseries(date, row[i].toDouble()));
		}

		return timeseries;
	}
}