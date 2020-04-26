import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:macaw/service/constant.dart';
import 'package:macaw/widget/macaw_widget_store.dart';

class NetworkService {

	static MacawWidgetStore _widgetStore = MacawWidgetStore();

	static Future<String> getResponseFromRemoteLocation(BuildContext context, String url, { bool externalErrorManager = false }) async {

		if(!await NetworkService._isNetworkConnected())
			return NetworkService._networkErrorManagementDecider(externalErrorManager, context);

		http.Response response = await NetworkService._hitRemoteLocation(url);

		return (response.statusCode == 200)
			? response.body
			: NetworkService._networkErrorManagementDecider(externalErrorManager, context);
	}

	static Future<http.Response> _hitRemoteLocation(String url) {
		return http.get(url);
	}

	static Object _manageNetworkError(BuildContext context) {

		showDialog<void>(
			context: context,
			barrierDismissible: false,
			builder: NetworkService._widgetStore.buildDefaultNetworkErrorDialog
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