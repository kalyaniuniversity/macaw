import 'package:macaw/model/country.dart';

class CovidData {

	List<Country> _countries = <Country>[];
	List<String> _headers;

	List<Country> get countries => this._countries;
	List<String> get headers => this._headers;

	set headers(List<String> headerList) => this._headers = headerList;

	void addCountry(Country country) {
		this._countries.add(country);
	}

	Country getCountryByName(String countryName) {

		for(Country country in this._countries)
			if(country.name == countryName)
				return country;

		return null;
	}

	bool hasCountryByName(String countryName) {
		return this._countries.any((country) => country.name == countryName);
	}
}