import 'package:macaw/service/constant.dart';

class MacawStateManagement {

	static bool rootStateManaged = false;
	static bool isInitialDataLoaded = false;

	static bool isIndiaLatestDateLoaded = false;
	static bool isIndiaConfirmedTotalLoaded = false;
	static bool isIndiaRecoveredTotalLoaded = false;
	static bool isIndiaDeceasedTotalLoaded = false;
	static bool isIndiaMostInfectedRegionLoaded = false;
	static bool isIndiaMostRecoveredRegionLoaded = false;
	static bool isIndiaMostDeceasedRegionLoaded = false;
	static bool isIndiaInfectedCountIncreaseLoaded = false;
	static bool isIndiaRecoveredCountIncreaseLoaded = false;
	static bool isIndiaDeceasedCountIncreaseLoaded = false;

	static bool isWorldLatestDateLoaded = false;
	static bool isWorldConfirmedTotalLoaded = false;
	static bool isWorldRecoveredTotalLoaded = false;
	static bool isWorldDeceasedTotalLoaded = false;
	static bool isWorldMostInfectedCountryLoaded = false;
	static bool isWorldMostRecoveredCountryLoaded = false;
	static bool isWorldMostDeceasedCountryLoaded = false;
	static bool isWorldInfectedCountIncreaseLoaded = false;
	static bool isWorldRecoveredCountIncreaseLoaded = false;
	static bool isWorldDeceasedCountIncreaseLoaded = false;

	static int currentViewFragment = Constant.VIEW_FRAGMENT_COVID_INDIA;

	static var appViewFragmentStateChangeCallback;

	static bool isAllDataLoaded() {
		return MacawStateManagement._isIndiaDataLoaded() && MacawStateManagement._isWorldDataLoaded();
	}

	static bool _isIndiaDataLoaded() {
		return isIndiaLatestDateLoaded
			&& isIndiaConfirmedTotalLoaded
			&& isIndiaMostInfectedRegionLoaded
			&& isIndiaInfectedCountIncreaseLoaded
			&& isIndiaRecoveredTotalLoaded
			&& isIndiaMostDeceasedRegionLoaded
			&& isIndiaRecoveredCountIncreaseLoaded
			&& isIndiaDeceasedTotalLoaded
			&& isIndiaMostDeceasedRegionLoaded
			&& isIndiaDeceasedCountIncreaseLoaded;
	}

	static bool _isWorldDataLoaded() {
		return isWorldLatestDateLoaded
			&& isWorldConfirmedTotalLoaded
			&& isWorldMostInfectedCountryLoaded
			&& isWorldInfectedCountIncreaseLoaded
			&& isWorldRecoveredTotalLoaded
			&& isWorldMostDeceasedCountryLoaded
			&& isWorldRecoveredCountIncreaseLoaded
			&& isWorldDeceasedTotalLoaded
			&& isWorldMostDeceasedCountryLoaded
			&& isWorldDeceasedCountIncreaseLoaded;
	}
}