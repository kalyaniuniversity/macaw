import 'package:macaw/model/coordinate.dart';
import 'package:macaw/model/timeseries.dart';

class Province {

	String _name;
	String _countryName;
	String _provinceCode = "n/a";
	double _perCapitaIncome;
	double _population;
	double _avgTemperature;
	Coordinate _coordinates;
	List<Timeseries> _timeseries;

	Province(this._name, this._countryName, this._coordinates, this._timeseries);

	String get name => this._name;

	set perCapitaIncome(double value) => this._perCapitaIncome = value;
	set population(double value) => this._population = value;
	set avgTemperature(double value) => this._avgTemperature = value;
	set provinceCode(String value) => this._provinceCode = value;

	Timeseries get lastTimeseries => this._timeseries.last;

	String getNameLabel() {
		return (this._name == "n/a") ? this._countryName : this._name;
	}

	List<Timeseries> getLatestNTimeseries(int n) {
		return this._timeseries.getRange(this._timeseries.length - n, this._timeseries.length).toList();
	}
}