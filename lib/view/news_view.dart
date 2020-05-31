import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/bloc/news/bloc.dart';
import 'package:macaw/model/news.dart';
import 'package:macaw/model/news_chunk.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:macaw/view/fragment/news/news_card.dart';
import 'package:macaw/view/fragment/news/news_date_header.dart';
import 'package:macaw/view/fragment/news/news_header.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {

	NewsView({ Key key }): super(key: key);

	@override
	NewsViewState createState() => NewsViewState();
}

class NewsViewState extends State<NewsView> {

	int _newsCount;

	@override
	void initState() {
		super.initState();
		BlocProvider.of<NewsBloc>(context).add(GetNewsChunks());
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			floatingActionButton: FloatingActionButton.extended(
				backgroundColor: MacawPalette.roseannaGradientEnd,
				label: Text(
					'go back',
					style: GoogleFonts.changa(),
				),
				icon: Icon(Icons.keyboard_arrow_left),
				foregroundColor: MacawPalette.greyTintD,
				onPressed: () {
					Navigator.pop(context);
				},
			),
			body: Container(
				child: BlocListener<NewsBloc, NewsState>(
					listener: (context, state) {
						if(state is NewsChunkErrorState) {
							Scaffold.of(context).showSnackBar(
								SnackBar(
									content: Text(state.errorMessage),
								)
							);
						}
					},
					child: BlocBuilder<NewsBloc, NewsState>(
						builder: (context, state) {
							if(state is InitialNewsState)
								return this._buildInitialWidget();
							else if(state is NewsLoadingState)
								return this._buildLoadingWidget();
							else if(state is NewsChunksLoadedState)
								return this._buildNewsListWidget(state.news);
							else if(state is NewsChunkErrorState)
								return this._buildInitialWidget(message: state.errorMessage);
							else
								return this._buildInitialWidget();
						},
					),
				),
			),
		);
	}

	Widget _buildInitialWidget({ String message }) {
		return (message == null) ? _buildLoadingWidget() : Text(message);
	}

	Widget _buildLoadingWidget() {
		return Container(
			padding: EdgeInsets.symmetric(vertical: 16),
			alignment: Alignment.center,
			child: CupertinoActivityIndicator(),
		);
	}

	Widget _buildNewsListWidget(List<NewsChunk> news) {

		List<News> allNews = List();

		for(NewsChunk newsChunk in news)
			allNews..addAll(newsChunk.indiaNews)..addAll(newsChunk.worldNews);

		return ListView.separated(
			itemBuilder: (context, index) => Padding(
				padding: this._getListItemPadding(index),
				child: this._listViewChildBuilder(index, allNews)
			),
			separatorBuilder: (context, index) => Divider(
				height: 5,
				color: Colors.white,
			),
			itemCount: allNews.length + 1
		);
	}

	Widget _listViewChildBuilder(int index, List<News> allNews) {

		if((index != 0) && ((index == 1) || ((index - 1).toDouble() % 7 == 0)))
			return NewsDateHeader(date: allNews[(index == 1) ? 0.round() : (index / 7).round()].date);

		switch(index) {
			case 0: return NewsHeader();
			default: return NewsCard(news: allNews[index - 2 - this._countMultipleOf7(index - 1)]);
		}
	}

	EdgeInsetsGeometry _getListItemPadding(int index) {
		switch(index) {
			case 0: return EdgeInsets.only(left: 0.0, right: 20.0, top: 100.0, bottom: 10.0);
			default: return EdgeInsets.all(15.0);
		}
	}

	int _countMultipleOf7(int value) {

		int count = 0;

		for(int i = 1; i <= value; i++)
			if(i.toDouble() % 7 == 0)
				++count;

		return count;
	}
}