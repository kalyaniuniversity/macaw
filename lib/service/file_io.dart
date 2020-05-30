import 'dart:io';

import 'package:macaw/service/constant.dart';
import 'package:path_provider/path_provider.dart';

class FileIO {

	Future<String> readCovidCSV(int type) async {
		try {

			File file;

			switch(type) {
				case Constant.FILE_TYPE_INDIA_CONFIRMED: file = await this._covidIndiaConfirmedLocalFile; break;
				case Constant.FILE_TYPE_INDIA_RECOVERED: file = await this._covidIndiaRecoveredLocalFile; break;
				case Constant.FILE_TYPE_INDIA_DECEASED: file = await this._covidIndiaDeceasedLocalFile; break;
				case Constant.FILE_TYPE_WORLD_CONFIRMED: file = await this._covidWorldConfirmedLocalFile; break;
				case Constant.FILE_TYPE_WORLD_RECOVERED: file = await this._covidWorldRecoveredLocalFile; break;
				case Constant.FILE_TYPE_WORLD_DECEASED: file = await this._covidWorldDeceasedLocalFile; break;

				default: return null;
			}

			if(!await file.exists()) return null;
			else return file.readAsString();
		} catch(e) {
			return null;
		}
	}

	Future<void> writeCovidCSV(String contents, int type) async {
		switch(type) {
			case Constant.FILE_TYPE_INDIA_CONFIRMED: await this._fileWriter(await this._covidIndiaConfirmedLocalFile, contents); break;
			case Constant.FILE_TYPE_INDIA_RECOVERED: await this._fileWriter(await this._covidIndiaRecoveredLocalFile, contents); break;
			case Constant.FILE_TYPE_INDIA_DECEASED: await this._fileWriter(await this._covidIndiaDeceasedLocalFile, contents); break;
			case Constant.FILE_TYPE_WORLD_CONFIRMED: await this._fileWriter(await this._covidWorldConfirmedLocalFile, contents); break;
			case Constant.FILE_TYPE_WORLD_RECOVERED: await this._fileWriter(await this._covidWorldRecoveredLocalFile, contents); break;
			case Constant.FILE_TYPE_WORLD_DECEASED: await this._fileWriter(await this._covidWorldDeceasedLocalFile, contents); break;

			default: return null;
		}
	}

	Future<String> readNewsJSON() async {
		try {

			File file = await this._covidNewsLocalFile;

			if(!await file.exists()) return null;
			else return file.readAsString();
		} catch(e) {
			return null;
		}
	}

	Future<void> writeNewsJSON(String contents) async {
		await this._fileWriter(await this._covidNewsLocalFile, contents);
	}

	Future<void> _fileWriter(File file, String contents) async {
		await file.writeAsString(contents);
	}

	Future<String> get _localFilePath async {
		return (await getApplicationDocumentsDirectory()).path;
	}

	Future<File> get _covidIndiaConfirmedLocalFile async {
		return File(await this._localFilePath + '/' + Constant.COVID_INDIA_CONFIRMED_CSV_FILENAME);
	}

	Future<File> get _covidIndiaRecoveredLocalFile async {
		return File(await this._localFilePath + '/' + Constant.COVID_INDIA_RECOVERED_CSV_FILENAME);
	}

	Future<File> get _covidIndiaDeceasedLocalFile async {
		return File(await this._localFilePath + '/' + Constant.COVID_INDIA_DECEASED_CSV_FILENAME);
	}

	Future<File> get _covidWorldConfirmedLocalFile async {
		return File(await this._localFilePath + '/' + Constant.COVID_WORLD_CONFIRMED_CSV_FILENAME);
	}

	Future<File> get _covidWorldRecoveredLocalFile async {
		return File(await this._localFilePath + '/' + Constant.COVID_WORLD_RECOVERED_CSV_FILENAME);
	}

	Future<File> get _covidWorldDeceasedLocalFile async {
		return File(await this._localFilePath + '/' + Constant.COVID_WORLD_DECEASED_CSV_FILENAME);
	}

	Future<File> get _covidNewsLocalFile async {
		return File(await this._localFilePath + "/" + Constant.COVID_NEWS_JSON_FILENAME);
	}
}