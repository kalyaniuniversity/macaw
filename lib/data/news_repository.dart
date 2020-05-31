import 'dart:convert';

import 'package:macaw/model/news_chunk.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/file_io.dart';
import 'package:macaw/service/network_service.dart';

abstract class NewsRepository {
	Future<List<NewsChunk>> fetchNews();
}

class NewsData implements NewsRepository {

	List<NewsChunk> _newsChunks = List();

	@override
	Future<List<NewsChunk>> fetchNews() async {

		await this._prepareNews();

		if(this._newsChunks.length == 0)
			throw Error();

		return this._newsChunks;
	}

	Future<void> _prepareNews() async {

		bool writeToDisk = false;
		String rawData = await FileIO.persistence.readNewsJSON();

		if(rawData == null) {
			writeToDisk = true;
			rawData = await NetworkService.fetchResponse(Constant.NEWS_URL);
		}

		this._prepareNewsChunks(rawData);

		if(writeToDisk)
			FileIO.persistence.writeNewsJSON(rawData);
	}

	void _prepareNewsChunks(String rawData) {
		for(dynamic news in json.decode(rawData))
			this._newsChunks.add(NewsChunk.fromJson(news));
	}
}