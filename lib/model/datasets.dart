import 'package:macaw/model/dataset.dart';

class Datasets {

	static final Dataset INDIA_CONFIRMED = Dataset(
		"India COVID-19 Timeseries Confirmed Cases",
		"University of Kalyani • GitHub",
		"https://github.com/kalyaniuniversity/COVID-19-Datasets/tree/master/India%20Statewise%20Confirmed%20Cases"
	);

	static final Dataset INDIA_RECOVERED = Dataset(
		"India COVID-19 Timeseries Recovery Cases",
		"University of Kalyani • GitHub",
		"https://github.com/kalyaniuniversity/COVID-19-Datasets/tree/master/India%20Statewise%20Recovery%20Cases"
	);

	static final Dataset INDIA_DECEASED = Dataset(
		"India COVID-19 Timeseries Deceased Cases",
		"University of Kalyani • GitHub",
		"https://github.com/kalyaniuniversity/COVID-19-Datasets/tree/master/India%20Statewise%20Death%20Cases"
	);

	static final Dataset WORLD_CONFIRMED = Dataset(
		"World COVID-19 Timeseries Deceased Cases",
		"JHS CCSE GIS • GitHub",
		"https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
	);

	static final Dataset WORLD_RECOVERED = Dataset(
		"World COVID-19 Timeseries Deceased Cases",
		"JHS CCSE GIS • GitHub",
		"https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"
	);

	static final Dataset WORLD_DECEASED = Dataset(
		"World COVID-19 Timeseries Deceased Cases",
		"JHS CCSE GIS • GitHub",
		"https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
	);

	static final List<Dataset> datasets = [
		INDIA_CONFIRMED,
		INDIA_RECOVERED,
		INDIA_DECEASED,
		WORLD_CONFIRMED,
		WORLD_RECOVERED,
		WORLD_DECEASED
	];
}