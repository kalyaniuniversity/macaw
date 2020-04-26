import 'package:flutter/material.dart';
import 'package:macaw/model/covid_india_state.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/service/workhorse.dart';
import 'package:macaw/widget/macaw_widget_store.dart';
import 'package:macaw/widget/quick_info.dart';
import 'package:macaw/widget/quick_info_style.dart';

class CovidIndiaWidgetStore {

	MacawWidgetStore _macawWidgetStore = MacawWidgetStore();

	Widget getView(BuildContext context) {
		return ListView.separated(
			separatorBuilder: this._listViewSeparatorBuilder,
			itemCount: 5,
			itemBuilder: (context, index) => Padding(
				padding: this._getListItemPadding(index),
				child: this._listViewChildBuilder(index)
			),
		);
	}

	Widget _listViewChildBuilder(int index) {
		switch(index) {
			case 0: return this._buildHeaderWidgetView();
			case 1: return this._buildNotifierPanelWidgetView();
			case 2: return this._buildRowOneWidgetView();
			case 3: return this._buildRowTwoWidgetView();
			case 4: return this._buildRowThreeWidgetView();
			default: return null;
		}
	}

	Widget _listViewSeparatorBuilder(BuildContext context, int index) {
		switch(index) {
			case 0:
			case 1: return this._macawWidgetStore.buildNoDivider(Colors.white70);
			default: return this._macawWidgetStore.buildDivider(MacawPalette.greyTintB);
		}
	}
	
	EdgeInsetsGeometry _getListItemPadding(int index) {
		switch(index) {
			case 0: return EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0);
			case 1: return EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0);
			case 2: return EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0, bottom: 15.0);
			default: return EdgeInsets.all(15.0);
		}
	}

	Widget _buildHeaderWidgetView() {
		return _macawWidgetStore.buildFragmentHeader(Constant.ASSET_TAJ_MAHAL_SVG, MacawPalette.roseannaGradient);
	}

	Widget _buildNotifierPanelWidgetView() {
		return (MacawStateManagement.isAllDataLoaded() || !MacawStateManagement.showLoadingProgressbar)
			? this._macawWidgetStore.buildDateNotifierWidgetView(Constant.INDIA.toUpperCase(), CovidIndiaState.latestDate)
			: this._macawWidgetStore.buildProgressIndicatorWidgetView();
	}

	Widget _buildRowOneWidgetView() {
		return this._macawWidgetStore.buildInfoRowView([this._buildTotalInfectedQuickInfo(), this._buildMostInfectedRegionQuickInfo()]);
	}

	Widget _buildRowTwoWidgetView() {
		return this._macawWidgetStore.buildInfoRowView([this._buildTotalRecoveredQuickInfo(), this._buildMostRecoveredRegionQuickInfo()]);
	}

	Widget _buildRowThreeWidgetView() {
		return this._macawWidgetStore.buildInfoRowView([this._buildTotalDeceasedQuickInfo(), this._buildMostDeceasedRegionQuickInfo()]);
	}

	Widget _buildTotalInfectedQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.TOTAL_INFECTED,
			Workhorse.numberFormat.format(CovidIndiaState.totalInfected),
			Constant.FACE_MASK_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidIndiaState.infectionCountIncrease),
			QuickInfoStyle.warningStyleSmallFont,
			QuickInfoStyle.warningExtraInfo
		));
	}

	Widget _buildMostInfectedRegionQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.REGION_WITH_HIGHEST_INFECTION,
			CovidIndiaState.highestInfectedRegion,
			Constant.FACE_MASK_EMOJI,
			Workhorse.numberFormat.format(CovidIndiaState.highestInfectionRegionCount),
			QuickInfoStyle.neutralStyle,
			QuickInfoStyle.warningExtraInfo
		), isNeutral: true);
	}

	Widget _buildTotalRecoveredQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.TOTAL_RECOVERED,
			Workhorse.numberFormat.format(CovidIndiaState.totalRecovered),
			Constant.FACE_SUNGLASS_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidIndiaState.recoveredCountIncrease),
			QuickInfoStyle.positiveStyleSmallFont,
			QuickInfoStyle.positiveExtraInfo
		));
	}

	Widget _buildMostRecoveredRegionQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.REGION_WITH_HIGHEST_RECOVERY,
			CovidIndiaState.highestRecoveredRegion,
			Constant.FACE_MASK_EMOJI,
			Workhorse.numberFormat.format(CovidIndiaState.highestRecoveredRegionCount),
			QuickInfoStyle.neutralStyle,
			QuickInfoStyle.positiveExtraInfo
		), isNeutral: true);
	}

	Widget _buildTotalDeceasedQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.TOTAL_DECEASED,
			Workhorse.numberFormat.format(CovidIndiaState.totalDeceased),
			Constant.SLIGHT_FROWNING_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidIndiaState.deceasedCountIncrease),
			QuickInfoStyle.dangerStyleSmallFont,
			QuickInfoStyle.dangerExtraInfo
		));
	}

	Widget _buildMostDeceasedRegionQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.REGION_WITH_HIGHEST_DECEASED,
			CovidIndiaState.highestDeceasedRegion,
			Constant.FACE_MASK_EMOJI,
			Workhorse.numberFormat.format(CovidIndiaState.highestDeceasedRegionCount),
			QuickInfoStyle.neutralStyle,
			QuickInfoStyle.dangerExtraInfo
		), isNeutral: true);
	}
}