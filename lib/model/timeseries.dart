class Timeseries {

	String _date;
	double _value;

	Timeseries(this._date, this._value);

	double get value => this._value;
	String get date => this._date;
}