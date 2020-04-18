import 'package:macaw/model/covid_data.dart';
import 'package:macaw/model/covid_india_state.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/model/province.dart';
import 'package:macaw/model/timeseries.dart';
import 'package:macaw/service/workhorse.dart';
import 'package:macaw/service/macaw_state_management.dart';

class DataProvider {

	static void provideIndiaConfirmedData() {

		DataProvider._setIndiaTotalInfected();
		DataProvider._setIndiaHighestInfectedRegion();
		DataProvider._setIndiaInfectedCountIncrease();
		DataProvider._setIndiaLatestDate();
		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
	}

	static void provideIndiaRecoveredData() {

		DataProvider._setIndiaTotalRecovered();
		DataProvider._setIndiaHighestRecoveredRegion();
		DataProvider._setIndiaRecoveredCountIncrease();
		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
	}

	static void provideIndiaDeceasedData() {

		DataProvider._setIndiaTotalDeceased();
		DataProvider._setIndiaHighestDeceasedRegion();
		DataProvider._setIndiaDeceasedCountIncrease();
		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
	}

	static void _setIndiaLatestDate() {
		if(DataManager.covidIndiaConfirmed.headers.length > 0) {
			CovidIndiaState.latestDate = DataManager.covidIndiaConfirmed.headers.last;
			MacawStateManagement.isIndiaLatestDateLoaded = true;
		}
	}

	static void _setIndiaTotalInfected() {
		CovidIndiaState.totalInfected = DataProvider._getIndiaTotalAffected(DataManager.covidIndiaConfirmed);;
		MacawStateManagement.isIndiaConfirmedTotalLoaded = true;
	}

	static void _setIndiaTotalRecovered() {
		CovidIndiaState.totalRecovered = DataProvider._getIndiaTotalAffected(DataManager.covidIndiaRecovered);;
		MacawStateManagement.isIndiaRecoveredTotalLoaded = true;
	}

	static void _setIndiaTotalDeceased() {
		CovidIndiaState.totalDeceased = DataProvider._getIndiaTotalAffected(DataManager.covidIndiaDeceased);
		MacawStateManagement.isIndiaDeceasedTotalLoaded = true;
	}

	static void _setIndiaInfectedCountIncrease() {
		CovidIndiaState.infectionCountIncrease = DataProvider._getIndiaAffectedCountIncrease(DataManager.covidIndiaConfirmed);
		MacawStateManagement.isIndiaInfectedCountIncreaseLoaded = true;
	}

	static void _setIndiaRecoveredCountIncrease() {
		CovidIndiaState.recoveredCountIncrease = DataProvider._getIndiaAffectedCountIncrease(DataManager.covidIndiaRecovered);
		MacawStateManagement.isIndiaRecoveredCountIncreaseLoaded = true;
	}

	static void _setIndiaDeceasedCountIncrease() {
		CovidIndiaState.deceasedCountIncrease = DataProvider._getIndiaAffectedCountIncrease(DataManager.covidIndiaDeceased);
		MacawStateManagement.isIndiaDeceasedCountIncreaseLoaded = true;
	}

	static double _getIndiaTotalAffected(CovidData covidData) {

		double result = 0;

		if(covidData.countries.length > 0)
			covidData.countries[0].provinces.forEach((province) => result += province.lastTimeseries.value);

		return result;
	}

	static double _getIndiaAffectedCountIncrease(CovidData covidData) {

		double previous = 0;
		double current = 0;

		if(covidData.countries.length > 0)
			covidData.countries[0].provinces.forEach((province) {
				List<Timeseries> latestTimeseries = province.getLatestNTimeseries(2);
				previous += latestTimeseries[0].value;
				current += latestTimeseries[1].value;
			});

		return current - previous;
	}

	static void _setIndiaHighestInfectedRegion() {

		Map<String, String> result = DataProvider._setIndiaHighestAffectedRegion(DataManager.covidIndiaConfirmed);
		CovidIndiaState.highestInfectedRegion = result['region'];
		CovidIndiaState.highestInfectionRegionCount = double.parse(result['affected']);
		MacawStateManagement.isIndiaMostInfectedRegionLoaded = true;
	}

	static void _setIndiaHighestRecoveredRegion() {

		Map<String, String> result = DataProvider._setIndiaHighestAffectedRegion(DataManager.covidIndiaRecovered);
		CovidIndiaState.highestRecoveredRegion = result['region'];
		CovidIndiaState.highestRecoveredRegionCount = double.parse(result['affected']);
		MacawStateManagement.isIndiaMostRecoveredRegionLoaded = true;
	}

	static void _setIndiaHighestDeceasedRegion() {

		Map<String, String> result = DataProvider._setIndiaHighestAffectedRegion(DataManager.covidIndiaDeceased);
		CovidIndiaState.highestDeceasedRegion = result['region'];
		CovidIndiaState.highestDeceasedRegionCount = double.parse(result['affected']);
		MacawStateManagement.isIndiaMostDeceasedRegionLoaded = true;
	}

	static Map<String, String> _setIndiaHighestAffectedRegion(CovidData covidData) {

		String region = "-";
		double maxAffected = 0;

		if(covidData.countries.length > 0)
			for(Province province in covidData.countries[0].provinces)
				if(maxAffected < province.lastTimeseries.value) {
					maxAffected = province.lastTimeseries.value;
					region = province.name;
				}

		return {
			"region": region,
			"affected": maxAffected.toString()
		};
	}
}