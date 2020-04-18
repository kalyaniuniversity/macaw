class Constant {

	static const String MATERIAL_APP_TITLE = "COVID-19 Analysis";
	static const String INDIA = "India";
	static const String WORLD = "World";
	static const String TRY_AGAIN = "Try Again";
	static const String DISMISS = "Dismiss";
	static const String TOTAL_INFECTED = "Total Infected";
	static const String TOTAL_RECOVERED = "Total Recovered";
	static const String TOTAL_DECEASED = "Total Deceased";
	static const String REGION_WITH_HIGHEST_INFECTION = "Region with Highest Infection";
	static const String REGION_WITH_HIGHEST_RECOVERY = "Region with Highest Recovery";
	static const String REGION_WITH_HIGHEST_DECEASED = "Region with Highest Deceased";

	static const String FACE_MASK_EMOJI = "😷";
	static const String SKULL_EMOJI = "☠️";
	static const String FACE_SUNGLASS_EMOJI = "😎";
//	static const String FACE_MASK_EMOJI = "😷";
//	static const String FACE_MASK_EMOJI = "😷";
//	static const String FACE_MASK_EMOJI = "😷";


	static const int VIEW_FRAGMENT_COVID_INDIA = 0;
	static const int VIEW_FRAGMENT_COVID_WORLD = 1;

	static const String INDIA_CONFIRMED_CASES_DATASET_URL = "https://raw.githubusercontent.com/kalyaniuniversity/COVID-19-Datasets/master/India%20Statewise%20Confirmed%20Cases/COVID19_INDIA_STATEWISE_TIME_SERIES_CONFIRMED.csv";
	static const String INDIA_RECOVERY_CASES_DATASET_URL = "https://raw.githubusercontent.com/kalyaniuniversity/COVID-19-Datasets/master/India%20Statewise%20Recovery%20Cases/COVID19_INDIA_STATEWISE_TIME_SERIES_RECOVERY.csv";
	static const String INDIA_DECEASED_CASES_DATASET_URL = "https://raw.githubusercontent.com/kalyaniuniversity/COVID-19-Datasets/master/India%20Statewise%20Death%20Cases/COVID19_INDIA_STATEWISE_TIME_SERIES_DEATH.csv";

	static const String INDIA_CONFIRMED_DATALOAD_FAILURE_MESSAGE = "The data for India's COVID-19 confirmed cases could not be loaded. This could be due to an internet connection failure or the server may not be available now.";
	static const String INDIA_RECOVERY_DATALOAD_FAILURE_MESSAGE = "The data for India's COVID-19 recovery cases could not be loaded. This could be due to an internet connection failure or the server may not be available now.";
	static const String INDIA_DECEASED_DATALOAD_FAILURE_MESSAGE = "The data for India's COVID-19 deceased cases could not be loaded. This could be due to an internet connection failure or the server may not be available now.";
	static const String NETWORK_FAILURE_MESSAGE = "A network failure occured. Please check if you have an active internet connection, or the remote server may be inaccessible. Try after sometime.";
	static const String NETWORK_FAILURE_MESSAGE_SHORT = "We failed to fetch information from the internet.";
}