class News {

	String _date;
	String _heading;
	String _description;
	String _source;

	News(this._date, this._heading, this._description, this._source);

	String get date => this._date;
	String get heading => this._heading;
	String get description => this._description;
	String get source => this._source;
}