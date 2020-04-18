class Coordinate {

	String _latitude;
	String _longitude;

	Coordinate(this._latitude, this._longitude);

	String getRoundedLatitude({ int precision = 3 }) {
		return double.parse(this._latitude).toStringAsFixed(precision);
	}

	double getAbsoluteLatitude() {
		return double.parse(this._latitude).abs();
	}
}