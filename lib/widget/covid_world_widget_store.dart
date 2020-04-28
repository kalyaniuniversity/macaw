import 'package:flutter/material.dart';
import 'package:macaw/controller/date_notifier_controller.dart';
import 'package:macaw/model/covid_world_state.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/data_subscription.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/macaw_state_management.dart';
import 'package:macaw/service/workhorse.dart';
import 'package:macaw/widget/macaw_fragment_header.dart';
import 'package:macaw/widget/macaw_widget_store.dart';
import 'package:macaw/widget/quick_info.dart';
import 'package:macaw/widget/quick_info_style.dart';

class CovidWorldWidgetStore {

	MacawWidgetStore _macawWidgetStore = MacawWidgetStore();
	DateNotifierController _dateNotifierController = DateNotifierController(key: Key('2'), subscriber: DataSubscription.worldLatestDateSubscription);

	Widget getView(BuildContext context) {
		return ListView.separated(
			separatorBuilder: this._listViewSeparatorBuilder,
			itemCount: 6,
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
			case 5: return this._dateNotifierController;
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
		return MacawFragmentHeader(Constant.ASSET_WORLD_SVG, MacawPalette.yellowGradient);
	}

	Widget _buildNotifierPanelWidgetView() {
		return (MacawStateManagement.isAllDataLoaded() || !MacawStateManagement.showLoadingProgressbar)
			? Container()
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
			Workhorse.numberFormat.format(CovidWorldState.totalInfected),
			Constant.ALIEN_MONSTER_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidWorldState.infectionCountIncrease),
			QuickInfoStyle.warningStyleSmallFont,
			QuickInfoStyle.warningExtraInfo
		));
	}

	Widget _buildMostInfectedRegionQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.COUNTRY_WITH_HIGHEST_INFECTION,
			CovidWorldState.highestInfectedCountry,
			Constant.FACE_MASK_EMOJI,
			Workhorse.numberFormat.format(CovidWorldState.highestInfectionCountryCount),
			QuickInfoStyle.neutralStyle,
			QuickInfoStyle.warningExtraInfo
		), isNeutral: true);
	}

	Widget _buildTotalRecoveredQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.TOTAL_RECOVERED,
			Workhorse.numberFormat.format(CovidWorldState.totalRecovered),
			Constant.VICTORY_HAND_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidWorldState.recoveredCountIncrease),
			QuickInfoStyle.positiveStyleSmallFont,
			QuickInfoStyle.positiveExtraInfo
		));
	}

	Widget _buildMostRecoveredRegionQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.COUNTRY_WITH_HIGHEST_RECOVERY,
			CovidWorldState.highestRecoveredCountry,
			Constant.FACE_MASK_EMOJI,
			Workhorse.numberFormat.format(CovidWorldState.highestRecoveredCountryCount),
			QuickInfoStyle.neutralStyle,
			QuickInfoStyle.positiveExtraInfo
		), isNeutral: true);
	}

	Widget _buildTotalDeceasedQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.TOTAL_DECEASED,
			Workhorse.numberFormat.format(CovidWorldState.totalDeceased),
			Constant.SKULL_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidWorldState.deceasedCountIncrease),
			QuickInfoStyle.dangerStyleSmallFont,
			QuickInfoStyle.dangerExtraInfo
		));
	}

	Widget _buildMostDeceasedRegionQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.COUNTRY_WITH_HIGHEST_DECEASED,
			CovidWorldState.highestDeceasedCountry,
			Constant.FACE_MASK_EMOJI,
			Workhorse.numberFormat.format(CovidWorldState.highestDeceasedCountryCount),
			QuickInfoStyle.neutralStyle,
			QuickInfoStyle.dangerExtraInfo
		), isNeutral: true);
	}
}