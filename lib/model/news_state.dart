import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/controller/news_controller.dart';
import 'package:macaw/model/news.dart';
import 'package:macaw/model/news_chunk.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/file_io.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/network_service.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsState extends State<NewsController> {

	static FileIO _persistance = FileIO();

	List<NewsChunk> _newsChunk = List();
	List<News> _allNews = List();
	bool _showProgressIndicator = true;

	@override
	void initState() {

		super.initState();

		this._showProgressIndicator = true;
		this._newsChunk = List();
	}

	@override
	Widget build(BuildContext context) {

		if(this._newsChunk.length == 0)
			this._prepareNews(context);
		else {

			this._allNews = List();

			for(NewsChunk newsChunk in this._newsChunk)
				this._allNews..addAll(newsChunk.indiaNews)..addAll(newsChunk.worldNews);
		}

		return Scaffold(
			floatingActionButton: FloatingActionButton.extended(
				backgroundColor: MacawPalette.greyTintC,
				label: Text(
					'go back',
					style: GoogleFonts.changa(),
				),
				icon: Icon(Icons.keyboard_arrow_left),
				foregroundColor: MacawPalette.darkBlue,
				onPressed: () {
					Navigator.pop(context);
				},
			),
			body: this._buildListView()
		);
	}

	Widget _buildListView() {
		return ListView.separated(
			itemBuilder: (context, index) => Padding(
				padding: this._getListItemPadding(index),
				child: this._listViewChildBuilder(index)
			),
			separatorBuilder: (context, index) => Divider(
				height: 5,
				color: Colors.white,
			),
			itemCount: this._getListItemCount()
		);
	}

	Widget _listViewChildBuilder(int index) {

		if(!this._showProgressIndicator && (index != 0) && ((index == 2) || ((index - 2).toDouble() % 7 == 0)))
			return _getDate(index);

		switch(index) {

			case 0: return this._progressIndicator(this._showProgressIndicator);
			case 1: return this._getHeader();

			default: return this._getNewsCard(index - 3 - this._countMultipleOf7(index - 2));
		}
	}

	Widget _getDate(int index) {

		int chunkIndex = (index == 2) ? 0.round() : (index / 7).round();
		String date = this._newsChunk[chunkIndex].date;

		return Column(
			children: <Widget>[
				Container(
					padding: EdgeInsets.only(bottom: 10.0),
					child: SvgPicture.asset(
						"assets/images/calendar.svg",
						height: 20.0,
					),
				),
				Center(
					child: Text(
						date,
						style: GoogleFonts.robotoMono(
							textStyle: TextStyle(
								fontWeight: FontWeight.bold,
								fontSize: 16.0,
								letterSpacing: 2.0,
								color: MacawPalette.roseannaGradientStart
							)
						),
					),
				)
			],
		);

		return Center(
			child: Text(
				date,
				style: GoogleFonts.robotoMono(
					textStyle: TextStyle(
						fontWeight: FontWeight.bold,
						fontSize: 16.0,
						letterSpacing: 2.0,
						color: MacawPalette.roseannaGradientStart
					)
				),
			),
		);
	}

	Widget _getNewsCard(int index) {

		News news = this._allNews[index];

		return Card(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					ListTile(
						contentPadding: EdgeInsets.all(10.0),
						leading: SvgPicture.asset(
							"assets/images/newspaper.svg",
							height: 30.0,
						),
						title: Text(
							news.heading,
							style: GoogleFonts.changa(
								textStyle: TextStyle(
									height: 1.5
								)
							),
						),
						subtitle: Text(
							news.description,
							style: GoogleFonts.changa(),
						),
						dense: true,
						onTap: () async {
							if(await canLaunch(news.source))
								await launch(news.source);
						},
					),
					Column(
						crossAxisAlignment: CrossAxisAlignment.end,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget> [
							Text(
								news.type,
								style: GoogleFonts.changa(
									textStyle: TextStyle(
										fontSize: 12,
										color: MacawPalette.accentColor
									)
								),
							)
						]
					)
				],
			),
		);
	}

	EdgeInsetsGeometry _getListItemPadding(int index) {
		switch(index) {
			case 0: return EdgeInsets.only(top: 100.0, left: 0.0, right: 0.0, bottom: 10.0);
			case 1: return EdgeInsets.only(left: 0.0, right: 20.0, top: 0.0, bottom: 0.0);
			default: return EdgeInsets.all(15.0);
		}
	}

	int _getListItemCount() {
		return this._showProgressIndicator ? 2 : (this._allNews.length + 1);
	}

	Widget _getHeader() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.end,
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget> [
				Text(
					"News",
					style: GoogleFonts.changa(
						textStyle: TextStyle(
							fontSize: 30,
							color: MacawPalette.greyTintD
						)
					),
				)
			]
		);
	}
	
	Widget _progressIndicator(bool show) {
		return show ? CupertinoActivityIndicator() : null;
	}

	void _parseNewsChunk(String data) {
		for(dynamic news in json.decode(data))
			this._newsChunk.add(NewsChunk.fromJson(news));
	}

	void _prepareNews(BuildContext context) async {

		String rawData = await this._getNews(context);
		
		this._parseNewsChunk(rawData);
		
		setState(() {
		  this._showProgressIndicator = false;
		});
	}

	Future<String> _getNews(BuildContext context) async {
		return await NetworkService.getResponseFromRemoteLocation(context, Constant.NEWS_URL);
	}

	int _countMultipleOf7(int value) {

		int count = 0;

		for(int i = 1; i <= value; i++)
			if(i.toDouble() % 7 == 0)
				++count;

		return count;
	}
}