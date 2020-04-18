import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
			case 1: return this._buildNoDivider();
			default: return this._buildDivider();
		}
	}
	
	EdgeInsetsGeometry _getListItemPadding(int index) {
		switch(index) {
			case 0: return EdgeInsets.only(top: 18.0, left: 10.0, right: 15.0);
			case 1: return EdgeInsets.only(left: 5.0, right: 5.0);
			case 2: return EdgeInsets.only(top: 2.0, left: 15.0, right: 15.0, bottom: 15.0);
			default: return EdgeInsets.all(15.0);
		}
	}

	Widget _buildNoDivider() {
		return Divider(
			color: Colors.white70,
			thickness: 0.0,
		);
	}

	Widget _buildDivider() {
		return Divider(
			color: MacawPalette.greyTintB,
			indent: 30.0,
			endIndent: 30.0,
			thickness: 3.0,
		);
	}

	Widget _buildHeaderWidgetView() {
		return _macawWidgetStore.buildFragmentHeader(Constant.INDIA);
	}

	Widget _buildNotifierPanelWidgetView() {
		return MacawStateManagement.isAllDataLoaded() ? this._buildDateNotifierWidgetView() : this._buildProgressIndicatorWidgetView();
	}

	Widget _buildDateNotifierWidgetView() {
		return Container(
			margin: const EdgeInsets.only(
				left: 4.0,
				right: 4.0
			),
			padding: const EdgeInsets.all(8.0),
			decoration: BoxDecoration(

			),
			child: RichText(
				text: TextSpan(
					children: <TextSpan>[
						TextSpan(
							text: "INDIA'S COVID-19 REPORTED CASES AS OF ",
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									color: Colors.black54,
									fontSize: 14.0
								)
							)
						),
						TextSpan(
							text: CovidIndiaState.latestDate,
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									color: MacawPalette.accentColor,
									fontSize: 16.0,
									fontWeight: FontWeight.bold
								)
							)
						),
						TextSpan(
							text: " (MM/DD/YYYY)",
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									color: Colors.black54,
									fontSize: 14.0
								)
							)
						)
					]
				),
			),
		);
	}

	Widget _buildProgressIndicatorWidgetView() {
		return Container(
			child: LinearProgressIndicator(
				backgroundColor: MacawPalette.greyTintC
			),
		);
	}

	Widget _buildRowOneWidgetView() {
		return this._buildInfoRowView([this._buildTotalInfectedQuickInfo(), this._buildMostInfectedRegionQuickInfo()]);
	}

	Widget _buildRowTwoWidgetView() {
		return this._buildInfoRowView([this._buildTotalRecoveredQuickInfo(), this._buildMostRecoveredRegionQuickInfo()]);
	}

	Widget _buildRowThreeWidgetView() {
		return this._buildInfoRowView([this._buildTotalDeceasedQuickInfo(), this._buildMostDeceasedRegionQuickInfo()]);
	}

	Widget _buildInfoRowView(List<Widget> widgets) {
		return Row(
			children: <Widget>[
				Expanded(
					child: widgets[0]
				),
				SizedBox(
					width: 8.0
				),
				Expanded(
					child: widgets[1]
				)
			],
		);
	}

	Widget _buildTotalInfectedQuickInfo() {
		return this._macawWidgetStore.buildQuickInfo(QuickInfo(
			Constant.TOTAL_INFECTED,
			Workhorse.numberFormat.format(CovidIndiaState.totalInfected),
			Constant.FACE_MASK_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidIndiaState.infectionCountIncrease),
			QuickInfoStyle.warningStyle,
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
			QuickInfoStyle.positiveStyle,
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
			Constant.SKULL_EMOJI,
			'+' + Workhorse.numberFormat.format(CovidIndiaState.deceasedCountIncrease),
			QuickInfoStyle.dangerStyle,
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