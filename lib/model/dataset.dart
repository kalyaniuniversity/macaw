class Dataset {

	final String _title;
	final String _subtitle;
	final String _url;

	Dataset(this._title, this._subtitle, this._url);

	String get title => this._title;
	String get subtitle => this._subtitle;
	String get url => this._url;
}