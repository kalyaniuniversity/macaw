import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:macaw/model/coordinate.dart';
import 'package:macaw/model/country.dart';
import 'package:macaw/model/covid_data.dart';
import 'package:macaw/model/province.dart';
import 'package:macaw/model/timeseries.dart';
import 'package:macaw/service/workhorse.dart';

const String INDIA_CONFIRMED_CASES_DATASET_URL = "https://raw.githubusercontent.com/kalyaniuniversity/COVID-19-Datasets/master/India%20Statewise%20Confirmed%20Cases/COVID19_INDIA_STATEWISE_TIME_SERIES_CONFIRMED.csv";

void main() async {
	testIndiaConfirmed();
}

void testIndiaConfirmed() async {

	http.Response response = await http.get(INDIA_CONFIRMED_CASES_DATASET_URL);

	if(response.statusCode == 200) {

		String data = response.body;

		List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(
			data,
			eol: '\n'
		);

		print("rows as list of values: " + rowsAsListOfValues.length.toString());
		print("element 0 list: " + rowsAsListOfValues[0].length.toString());
		print("header list: " + rowsAsListOfValues[0].cast<String>().toList().length.toString());



		CovidData covidData = CovidData();

		Country india = Country("India");
		covidData.headers = rowsAsListOfValues[0].cast<String>().toList();
		int i = 1;

		for(i = 1; i < (rowsAsListOfValues.length - 2); i++) {

			List<dynamic> row = rowsAsListOfValues[i];
			String provinceName = row[0].toString();
			String provinceCode = row[1].toString();
			String latitude = row[2].toString();
			String longitude = row[3].toString();
			double perCapitaIncome = Workhorse.getNumberFromCommaSeparatedString(row[4].toString());
			double population = Workhorse.getNumberFromCommaSeparatedString(row[5].toString());
			double avgTemperature = double.parse(row[6].toString());
			List<Timeseries> timeseries = Workhorse.prepareTimeseries(row, covidData.headers, 7);
			Coordinate coordinates = new Coordinate(latitude, longitude);
			Province province = Province(provinceName, "India", coordinates, timeseries);

			province.perCapitaIncome = perCapitaIncome;
			province.population = population;
			province.avgTemperature = avgTemperature;
			province.provinceCode = provinceCode;

			india.addProvince(province);
		}


		print("\n\nUNASSIGNED\n\n\n");



		List<dynamic> row = rowsAsListOfValues[i];
		String provinceName = row[0].toString();
		String provinceCode = row[1].toString();
		String latitude = row[2].toString();
		String longitude = row[3].toString();

		print("pn: " + provinceName);
		print("pc: " + provinceCode);
		print("lat: " + latitude);
		print("long: " + longitude);


		double perCapitaIncome = Workhorse.getNumberFromCommaSeparatedString(row[4].toString());
		double population = Workhorse.getNumberFromCommaSeparatedString(row[5].toString());
		double avgTemperature = double.parse(row[6].toString());

		print("pci: " + perCapitaIncome.toString());
		print("pop: " + population.toString());
	}
}