import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macaw/model/coordinate.dart';
import 'package:macaw/model/country.dart';
import 'package:macaw/model/covid_data.dart';
import 'package:macaw/model/covid_india_state.dart';
import 'package:macaw/model/data_provider.dart';
import 'package:macaw/model/province.dart';
import 'package:macaw/model/timeseries.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/service/workhorse.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/network_service.dart';
import 'package:macaw/widget/macaw_widget_store.dart';

class DataManager {

	static CovidData covidIndiaConfirmed = CovidData();
	static CovidData covidIndiaRecovered = CovidData();
	static CovidData covidIndiaDeceased = CovidData();

	static MacawWidgetStore _widgetStore = MacawWidgetStore();

	static void loadData(BuildContext context) {

		if(!MacawStateManagement.isInitialDataLoaded) {

			DataManager._prepareIndiaConfirmedData(context);
			DataManager._prepareIndiaRecoveredData(context);
			DataManager._prepareIndiaDeceasedData(context);

			MacawStateManagement.isInitialDataLoaded = true;
		}
	}

	static void _prepareIndiaConfirmedData(BuildContext context) async {
		DataManager._prepareIndiaData(
			context: context,
			url: Constant.INDIA_CONFIRMED_CASES_DATASET_URL,
			failureMessage: Constant.INDIA_CONFIRMED_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidIndiaConfirmed,
			dataManagerCallback: DataProvider.provideIndiaConfirmedData
		);
	}

	static void _prepareIndiaRecoveredData(BuildContext context) async {
		DataManager._prepareIndiaData(
			context: context,
			url: Constant.INDIA_RECOVERY_CASES_DATASET_URL,
			failureMessage: Constant.INDIA_RECOVERY_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidIndiaRecovered,
			dataManagerCallback: DataProvider.provideIndiaRecoveredData
		);
	}

	static void _prepareIndiaDeceasedData(BuildContext context) async {
		DataManager._prepareIndiaData(
			context: context,
			url: Constant.INDIA_DECEASED_CASES_DATASET_URL,
			failureMessage: Constant.INDIA_DECEASED_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidIndiaDeceased,
			dataManagerCallback: DataProvider.provideIndiaDeceasedData
		);
	}

	static void _prepareIndiaData({ @required BuildContext context,
		@required String url,
		@required String failureMessage,
		@required CovidData covidData,
		@required Function dataManagerCallback }) async {

		String rawData = await NetworkService.getResponseFromRemoteLocation(context, url, externalErrorManager: true);

		if(rawData == null) {

			showDialog<void>(
				context: context,
				barrierDismissible: false,
				builder: (BuildContext dialogContext) => DataManager._widgetStore.buildNetworkErrorAlertDialog(dialogContext, context, failureMessage)
			); return;
		}

		List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(rawData);

		DataManager._prepareCovidIndiaDataObject(rowsAsListOfValues, covidData);
		dataManagerCallback();
	}

	static void _prepareCovidIndiaDataObject(List<List<dynamic>> rowsAsListOfValues, CovidData covidData) {

		Country india = Country(Constant.INDIA);
		covidData.headers = rowsAsListOfValues[0].cast<String>().toList();

		for(int i = 1; i < (rowsAsListOfValues.length - 1); i++) {

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
			Province province = Province(provinceName, Constant.INDIA, coordinates, timeseries);

			province.perCapitaIncome = perCapitaIncome;
			province.population = population;
			province.avgTemperature = avgTemperature;
			province.provinceCode = provinceCode;

			india.addProvince(province);
		}

		covidData.addCountry(india);
	}
}