import 'package:macaw/service/constant.dart';

class News {

	String _date;
	String _heading;
	String _description;
	String _source;
	String _type;

	News(this._date, this._heading, this._description, this._source, this._type);

	factory News.fromJson(String date, String type, dynamic jsonBlob) {
		return News(
			date,
			jsonBlob[Constant.HEADING] as String,
			jsonBlob[Constant.DESCRIPTION] as String,
			jsonBlob[Constant.SOURCE] as String,
			type
		);
	}

	String get date => this._date;
	String get heading => this._heading;
	String get description => this._description;
	String get source => this._source;
	String get type => this._type;
}