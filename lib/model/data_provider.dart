import 'package:macaw/model/country.dart';
import 'package:macaw/model/covid_data.dart';
import 'package:macaw/model/covid_india_state.dart';
import 'package:macaw/model/covid_world_state.dart';
import 'package:macaw/model/data_manager.dart';
import 'package:macaw/model/province.dart';
import 'package:macaw/model/timeseries.dart';
import 'package:macaw/service/data_subscription.dart';
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

	static void provideWorldConfirmedData() {

		DataProvider._setWorldTotalInfected();
		DataProvider._setWorldHighestInfectedCountry();
		DataProvider._setWorldInfectedCountIncrease();
		DataProvider._setWorldLatestDate();
		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
	}

	static void provideWorldRecoveredData() {

		DataProvider._setWorldTotalRecovered();
		DataProvider._setWorldHighestRecoveredCountry();
		DataProvider._setWorldRecoveredCountIncrease();
		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
	}

	static void provideWorldDeceasedData() {

		DataProvider._setWorldTotalDeceased();
		DataProvider._setWorldHighestDeceasedCountry();
		DataProvider._setWorldDeceasedCountIncrease();
		MacawStateManagement.appViewFragmentStateChangeCallback(MacawStateManagement.currentViewFragment);
	}

	static void _setIndiaLatestDate() {
		if(DataManager.covidIndiaConfirmed.headers.length > 0) {
			DataSubscription.renewIndiaLatestDate(DataManager.covidIndiaConfirmed.headers.last);
			MacawStateManagement.isIndiaLatestDateLoaded = true;
		}
	}

	static void _setWorldLatestDate() {
		if(DataManager.covidWorldConfirmed.headers.length > 0) {
			DataSubscription.renewWorldLatestDate(DataManager.covidWorldConfirmed.headers.last);
			MacawStateManagement.isWorldLatestDateLoaded = true;
		}
	}

	static void _setIndiaTotalInfected() {
		CovidIndiaState.totalInfected = DataProvider._getIndiaTotalAffected(DataManager.covidIndiaConfirmed);;
		MacawStateManagement.isIndiaConfirmedTotalLoaded = true;
	}

	static void _setWorldTotalInfected() {
		CovidWorldState.totalInfected = DataProvider._getWorldTotalAffected(DataManager.covidWorldConfirmed);;
		MacawStateManagement.isWorldConfirmedTotalLoaded = true;
	}

	static void _setIndiaTotalRecovered() {
		CovidIndiaState.totalRecovered = DataProvider._getIndiaTotalAffected(DataManager.covidIndiaRecovered);;
		MacawStateManagement.isIndiaRecoveredTotalLoaded = true;
	}

	static void _setWorldTotalRecovered() {
		CovidWorldState.totalRecovered = DataProvider._getWorldTotalAffected(DataManager.covidWorldRecovered);;
		MacawStateManagement.isWorldRecoveredTotalLoaded = true;
	}

	static void _setIndiaTotalDeceased() {
		CovidIndiaState.totalDeceased = DataProvider._getIndiaTotalAffected(DataManager.covidIndiaDeceased);
		MacawStateManagement.isIndiaDeceasedTotalLoaded = true;
	}

	static void _setWorldTotalDeceased() {
		CovidWorldState.totalDeceased = DataProvider._getWorldTotalAffected(DataManager.covidWorldDeceased);
		MacawStateManagement.isWorldDeceasedTotalLoaded = true;
	}

	static void _setIndiaInfectedCountIncrease() {
		CovidIndiaState.infectionCountIncrease = DataProvider._getIndiaAffectedCountIncrease(DataManager.covidIndiaConfirmed);
		MacawStateManagement.isIndiaInfectedCountIncreaseLoaded = true;
	}

	static void _setWorldInfectedCountIncrease() {
		CovidWorldState.infectionCountIncrease = DataProvider._getWorldAffectedCountIncrease(DataManager.covidWorldConfirmed);
		MacawStateManagement.isWorldInfectedCountIncreaseLoaded = true;
	}

	static void _setIndiaRecoveredCountIncrease() {
		CovidIndiaState.recoveredCountIncrease = DataProvider._getIndiaAffectedCountIncrease(DataManager.covidIndiaRecovered);
		MacawStateManagement.isIndiaRecoveredCountIncreaseLoaded = true;
	}

	static void _setWorldRecoveredCountIncrease() {
		CovidWorldState.recoveredCountIncrease = DataProvider._getWorldAffectedCountIncrease(DataManager.covidWorldRecovered);
		MacawStateManagement.isWorldRecoveredCountIncreaseLoaded = true;
	}

	static void _setIndiaDeceasedCountIncrease() {
		CovidIndiaState.deceasedCountIncrease = DataProvider._getIndiaAffectedCountIncrease(DataManager.covidIndiaDeceased);
		MacawStateManagement.isIndiaDeceasedCountIncreaseLoaded = true;
	}

	static void _setWorldDeceasedCountIncrease() {
		CovidWorldState.deceasedCountIncrease = DataProvider._getWorldAffectedCountIncrease(DataManager.covidWorldDeceased);
		MacawStateManagement.isWorldDeceasedCountIncreaseLoaded = true;
	}

	static double _getIndiaTotalAffected(CovidData covidData) {

		double result = 0;

		if(covidData.countries.length > 0)
			covidData.countries[0].provinces.forEach((province) => result += province.lastTimeseries.value);

		return result;
	}

	static double _getWorldTotalAffected(CovidData covidData) {

		double result = 0;

		if(covidData.countries.length > 0)
			for(Country country in covidData.countries)
				country.provinces.forEach((province) => result += province.lastTimeseries.value);

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

	static double _getWorldAffectedCountIncrease(CovidData covidData) {

		double previous = 0;
		double current = 0;

		if(covidData.countries.length > 0)
			for(Country country in covidData.countries)
				country.provinces.forEach((province) {
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

	static void _setWorldHighestInfectedCountry() {

		Map<String, String> result = DataProvider._setWorldHighestAffectedCountry(DataManager.covidWorldConfirmed);
		CovidWorldState.highestInfectedCountry = result['country'];
		CovidWorldState.highestInfectionCountryCount = double.parse(result['affected']);
		MacawStateManagement.isWorldMostInfectedCountryLoaded = true;
	}

	static void _setIndiaHighestRecoveredRegion() {

		Map<String, String> result = DataProvider._setIndiaHighestAffectedRegion(DataManager.covidIndiaRecovered);
		CovidIndiaState.highestRecoveredRegion = result['region'];
		CovidIndiaState.highestRecoveredRegionCount = double.parse(result['affected']);
		MacawStateManagement.isIndiaMostRecoveredRegionLoaded = true;
	}

	static void _setWorldHighestRecoveredCountry() {

		Map<String, String> result = DataProvider._setWorldHighestAffectedCountry(DataManager.covidWorldRecovered);
		CovidWorldState.highestRecoveredCountry = result['country'];
		CovidWorldState.highestRecoveredCountryCount = double.parse(result['affected']);
		MacawStateManagement.isWorldMostRecoveredCountryLoaded = true;
	}

	static void _setIndiaHighestDeceasedRegion() {

		Map<String, String> result = DataProvider._setIndiaHighestAffectedRegion(DataManager.covidIndiaDeceased);
		CovidIndiaState.highestDeceasedRegion = result['region'];
		CovidIndiaState.highestDeceasedRegionCount = double.parse(result['affected']);
		MacawStateManagement.isIndiaMostDeceasedRegionLoaded = true;
	}

	static void _setWorldHighestDeceasedCountry() {

		Map<String, String> result = DataProvider._setWorldHighestAffectedCountry(DataManager.covidWorldDeceased);
		CovidWorldState.highestDeceasedCountry = result['country'];
		CovidWorldState.highestDeceasedCountryCount = double.parse(result['affected']);
		MacawStateManagement.isWorldMostDeceasedCountryLoaded = true;
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

	static Map<String, String> _setWorldHighestAffectedCountry(CovidData covidData) {

		String countryName = "-";
		double maxAffected = 0;

		if(covidData.countries.length > 0)
			covidData.countries.forEach((country) {

				double totalAffected = 0;
				country.provinces.forEach((province) => totalAffected += province.lastTimeseries.value);

				if(maxAffected < totalAffected) {
					maxAffected = totalAffected;
					countryName = country.name;
				}
			});

		return {
			"country": countryName,
			"affected": maxAffected.toString()
		};
	}
}