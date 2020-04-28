class Subscriber {

	var _dataMap;
	Function callback;

	Subscriber(this._dataMap);

	String getStringDataByKey(String key) => this._dataMap[key];

	void setDataByKey(String key, String value) => this._dataMap[key] = value;
}