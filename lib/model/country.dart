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
}