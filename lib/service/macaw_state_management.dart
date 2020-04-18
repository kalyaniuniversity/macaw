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

	static int currentViewFragment = Constant.VIEW_FRAGMENT_COVID_INDIA;

	static var appViewFragmentStateChangeCallback;

	static bool isAllDataLoaded() {
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
}