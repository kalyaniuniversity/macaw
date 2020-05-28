import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/controller/news_controller.dart';
import 'package:macaw/model/news_chunk.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/service/network_service.dart';
import 'package:http/http.dart' as http;

class NewsState extends State<NewsController> {

	List<NewsChunk> _newsChunk = List();

	@override
	void initState() {

		super.initState();
		this._prepareNews();


	}

	@override
	Widget build(BuildContext context) {
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
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: <Widget>[
					CupertinoActivityIndicator(),
					this._getHeader()
				],
			),
		);
	}

	Widget _buildListView() {
		return ListView.separated(
			itemBuilder: null,
			separatorBuilder: (context, index) => Divider(
				height: 5,
				color: Colors.white,
			),
			itemCount: null
		);
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

	void _prepareNews() async {

		String rawData = await this._getNews();

		print(rawData);

		this._newsChunk = this.parseNews(rawData);
	}

	List<NewsChunk> parseNews(String data) {

		final parsed = json.decode(data).cast<String, dynamic>();

		return parsed.map<NewsChunk>((json) => NewsChunk.fromJson(json)).toList();
	}

	Future<String> _getNews() async {

		http.Response response = await NetworkService.hitRemoteLocation(Constant.NEWS_URL);

		if(response.statusCode == 200) {
			return response.body;
		} else {
			// error here
		}
		return null;
	}
}