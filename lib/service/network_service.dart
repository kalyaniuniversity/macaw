import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:macaw/service/constant.dart';
import 'package:macaw/widget/macaw_default_network_error_dialog.dart';
import 'package:macaw/widget/macaw_widget_store.dart';

class NetworkService {

	static Future<String> fetchResponse(String url) async {

		if(!await NetworkService._isNetworkConnected())
			throw NetworkError(NetworkError.NO_INTERNET_CONNECTION);

		http.Response response = await NetworkService.hitRemoteLocation(url);

		return (response.statusCode == 200)
			? response.body
			: throw NetworkError(response.statusCode);
	}
















	///////////////////// refactor to not use context at all

	static Future<String> getResponseFromRemoteLocation(BuildContext context, String url, { bool externalErrorManager = false }) async {

		if(!await NetworkService._isNetworkConnected())
			return NetworkService._networkErrorManagementDecider(externalErrorManager, context);

		http.Response response = await NetworkService.hitRemoteLocation(url);

		return (response.statusCode == 200)
			? response.body
			: NetworkService._networkErrorManagementDecider(externalErrorManager, context);
	}

	static Future<http.Response> hitRemoteLocation(String url) {
		return http.get(url);
	}

	static Object _manageNetworkError(BuildContext context) {

		showDialog<void>(
			context: context,
			barrierDismissible: false,
			builder: (context) => MacawDefaultNetworkErrorDialog()
		);

		return null;
	}

	static Future<String> _networkErrorManagementDecider(bool externalErrorManager, BuildContext context) async {
		return externalErrorManager ? null : NetworkService._manageNetworkError(context).toString();
	}

	static Future<bool> _isNetworkConnected() async {
		try {
			if(await (Connectivity().checkConnectivity()) == ConnectivityResult.none) return false;
			final List<InternetAddress> result  = await InternetAddress.lookup(Constant.DEBACHARYA_COM);
			if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
			return false;
		} catch(e) {
			return false;
		}
	}
}

class NetworkError extends Error {

	static const int NO_INTERNET_CONNECTION = 900;
	static const int CODE_404 = 404;

	final int _code;

	NetworkError(this._code);

	int get code => this._code;

	static String resolveErrorCode(int code) {
		switch(code) {
			case NetworkError.NO_INTERNET_CONNECTION: return "It seems like you are not connected to the internet!";
			case NetworkError.CODE_404: return "The requested could not be found at the location.";
			default: return "Something went wrong!";
		}
	}
}