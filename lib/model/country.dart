import 'package:macaw/model/coordinate.dart';
import 'package:macaw/model/province.dart';

class Country {

	String _name;
	List<Province> _provinces = <Province>[];

	Country(this._name);

	String get name => this._name;
	List<Province> get provinces => this._provinces;

	void addProvince(Province province) {
		this._provinces.add(province);
	}

	Province getProvinceByName(String provinceName) {

		for(Province province in this._provinces)
			if(province.name == provinceName)
				return province;

		return null;
	}

	bool hasProvinceByName(String provinceName) {
		return this._provinces.any((province) => province.name == provinceName);
	}

	double totalAffected() {

		double result = 0;

		for(Province province in this._provinces)
			result += province.lastTimeseries.value;

		return result;
	}

	Coordinate getAverageCoordinates() {

		double latitude = 0;
		double longitude = 0;

		for(Province province in this._provinces) {
			latitude += double.parse(province.coordinate.latitude);
			longitude += double.parse(province.coordinate.longitude);
		}

		latitude = latitude / this._provinces.length;
		longitude = longitude / this._provinces.length;

		return Coordinate(
			latitude.toString(),
			longitude.toString()
		);
	}
}