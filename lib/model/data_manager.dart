import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macaw/model/coordinate.dart';
import 'package:macaw/model/country.dart';
import 'package:macaw/model/covid_data.dart';
import 'package:macaw/model/data_provider.dart';
import 'package:macaw/model/province.dart';
import 'package:macaw/model/timeseries.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/file_io.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/service/network_service.dart';
import 'package:macaw/service/workhorse.dart';
import 'package:macaw/widget/macaw_network_error_alert_dialog.dart';

class DataManager {

	static FileIO _persistence = FileIO();

	static CovidData covidIndiaConfirmed = CovidData();
	static CovidData covidIndiaRecovered = CovidData();
	static CovidData covidIndiaDeceased = CovidData();

	static CovidData covidWorldConfirmed = CovidData();
	static CovidData covidWorldRecovered = CovidData();
	static CovidData covidWorldDeceased = CovidData();

	static Future<void> loadData(BuildContext context, { refresh = false }) async {

		if(!MacawStateManagement.isInitialDataLoaded) {

			await Future.wait([
				DataManager._prepareCovidIndiaData(context, refresh),
				DataManager._prepareCovidWorldData(context, refresh)
			]);

			MacawStateManagement.isInitialDataLoaded = true;
		}
	}

	static Future<void> refreshData(BuildContext context) async {

		MacawStateManagement.isInitialDataLoaded = false;
		MacawStateManagement.isIndiaLatestDateLoaded = false;
		MacawStateManagement.isWorldLatestDateLoaded = false;

		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
		await DataManager.loadData(context, refresh: true);
	}

	static Future<void> _prepareCovidIndiaData(BuildContext context, bool refresh) async {
		await Future.wait([
			DataManager._prepareIndiaConfirmedData(context, refresh),
			DataManager._prepareIndiaRecoveredData(context, refresh),
			DataManager._prepareIndiaDeceasedData(context, refresh)
		]);
	}

	static Future<void> _prepareCovidWorldData(BuildContext context, bool refresh) async {
		await Future.wait([
			DataManager._prepareWorldConfirmedData(context, refresh),
			DataManager._prepareWorldRecoveredData(context, refresh),
			DataManager._prepareWorldDeceasedData(context, refresh)
		]);
	}

	static Future<void> _prepareIndiaConfirmedData(BuildContext context, bool refresh) async {
		await DataManager._prepareCovidData(
			context: context,
			url: Constant.INDIA_CONFIRMED_CASES_DATASET_URL,
			failureMessage: Constant.INDIA_CONFIRMED_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidIndiaConfirmed,
			csvFileType: Constant.FILE_TYPE_INDIA_CONFIRMED,
			refresh: refresh,
			india: true,
			dataManagerCallback: DataProvider.provideIndiaConfirmedData
		);
	}

	static Future<void> _prepareIndiaRecoveredData(BuildContext context, bool refresh) async {
		await DataManager._prepareCovidData(
			context: context,
			url: Constant.INDIA_RECOVERY_CASES_DATASET_URL,
			failureMessage: Constant.INDIA_RECOVERY_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidIndiaRecovered,
			csvFileType: Constant.FILE_TYPE_INDIA_RECOVERED,
			refresh: refresh,
			india: true,
			dataManagerCallback: DataProvider.provideIndiaRecoveredData
		);
	}

	static Future<void> _prepareIndiaDeceasedData(BuildContext context, bool refresh) async {
		await DataManager._prepareCovidData(
			context: context,
			url: Constant.INDIA_DECEASED_CASES_DATASET_URL,
			failureMessage: Constant.INDIA_DECEASED_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidIndiaDeceased,
			csvFileType: Constant.FILE_TYPE_INDIA_DECEASED,
			refresh: refresh,
			india: true,
			dataManagerCallback: DataProvider.provideIndiaDeceasedData
		);
	}

	static Future<void> _prepareWorldConfirmedData(BuildContext context, bool refresh) async {
		await DataManager._prepareCovidData(
			context: context,
			url: Constant.WORLD_CONFIRMED_CASES_DATASET_URL,
			failureMessage: Constant.WORLD_CONFIRMED_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidWorldConfirmed,
			csvFileType: Constant.FILE_TYPE_WORLD_CONFIRMED,
			refresh: refresh,
			world: true,
			dataManagerCallback: DataProvider.provideWorldConfirmedData
		);
	}

	static Future<void> _prepareWorldRecoveredData(BuildContext context, bool refresh) async {
		await DataManager._prepareCovidData(
			context: context,
			url: Constant.WORLD_RECOVERY_CASES_DATASET_URL,
			failureMessage: Constant.WORLD_RECOVERY_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidWorldRecovered,
			csvFileType: Constant.FILE_TYPE_WORLD_RECOVERED,
			refresh: refresh,
			world: true,
			dataManagerCallback: DataProvider.provideWorldRecoveredData
		);
	}

	static Future<void> _prepareWorldDeceasedData(BuildContext context, bool refresh) async {
		await DataManager._prepareCovidData(
			context: context,
			url: Constant.WORLD_DECEASED_CASES_DATASET_URL,
			failureMessage: Constant.WORLD_DECEASED_DATALOAD_FAILURE_MESSAGE,
			covidData: DataManager.covidWorldDeceased,
			csvFileType: Constant.FILE_TYPE_WORLD_DECEASED,
			refresh: refresh,
			world: true,
			dataManagerCallback: DataProvider.provideWorldDeceasedData
		);
	}

	static Future<void> _prepareCovidData({ @required BuildContext context,
		@required String url,
		@required String failureMessage,
		@required CovidData covidData,
		@required Function dataManagerCallback,
		@required int csvFileType,
		@required bool refresh,
		bool india = false,
		bool world = false }) async {

		bool hasError = false;
		bool writeToFile = false;
		String rawData = refresh ? null : await DataManager._persistence.readCovidCSV(csvFileType);

		if(rawData == null) {
			writeToFile = true;
			rawData = await NetworkService.getResponseFromRemoteLocation(context, url, externalErrorManager: true);
		}

		if(rawData == null) hasError = true;

		try {
			if(!hasError) {

				List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(
					rawData,
					eol: '\n'
				);

				if(writeToFile) DataManager._persistence.writeCovidCSV(rawData, csvFileType);
				if(india) DataManager._prepareCovidIndiaDataObject(rowsAsListOfValues, covidData);
				if(world) DataManager._prepareCovidWorldDataObject(rowsAsListOfValues, covidData);
			}
		} catch(e) {
		} finally {
			if(hasError) showDialog<void>(
				context: context,
				barrierDismissible: false,
				builder: (BuildContext dialogContext) => MacawNetworkErrorAlertDialog(context, failureMessage)
			);
		}

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
			double avgTemperature = Workhorse.getAvgTemperature(row[6].toString());
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

	static void _prepareCovidWorldDataObject(List<List<dynamic>> rowsAsListOfValues, CovidData covidData) {

		try {
			covidData.headers = rowsAsListOfValues[0].cast<String>().toList();

			for(int i = 1; i < (rowsAsListOfValues.length - 1); i++) {

				List<dynamic> row = rowsAsListOfValues[i];
				String provinceName = (row[0].toString().length == 0) ? "n/a" : row[0].toString();
				String countryName = row[1].toString();
				String latitude = row[2].toString();
				String longitude = row[3].toString();
				List<Timeseries> timeseries = Workhorse.prepareTimeseries(row, covidData.headers, 4);
				Coordinate coordinates = new Coordinate(latitude, longitude);
				Province province = Province(provinceName, countryName, coordinates, timeseries);
				Country country = Country(countryName);

				if(!covidData.hasCountryByName(countryName)) covidData.addCountry(country);
				else country = covidData.getCountryByName(countryName);

				if(!country.hasProvinceByName(provinceName)) country.addProvince(province);
			}
		} catch(e) {
			throw e;
		}
	}
}