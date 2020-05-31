import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macaw/bloc/news/bloc.dart';
import 'package:macaw/data/news_repository.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_theme.dart';
import 'package:macaw/view/about.dart';
import 'package:macaw/view/dataset_view.dart';
import 'package:macaw/view/home.dart';
import 'package:macaw/view/news_view.dart';
import 'package:macaw/widget/macaw.dart';

void main() => runApp(MacawApp());

class MacawApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: Constant.MATERIAL_APP_TITLE,
			theme: MacawTheme.primaryTheme,
			home: Home(),
			routes: {
				Constant.ROUTE_ABOUT: (context) => About(),
				Constant.ROUTE_DATASETS: (context) => DatasetView(),
				Constant.ROUTE_NEWS: (context) => BlocProvider(
					create: (context) => NewsBloc(NewsData()),
					child: NewsView(),
				)
			},
			debugShowMaterialGrid: false,
			showPerformanceOverlay: false,
			checkerboardRasterCacheImages: false,
			checkerboardOffscreenLayers: false,
			showSemanticsDebugger: false,
			debugShowCheckedModeBanner: false
		);
	}
}