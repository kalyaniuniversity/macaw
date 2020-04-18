import 'package:flutter/material.dart';
import 'package:macaw/controller/root_controller.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_theme.dart';

void main() => runApp(Macaw());

class Macaw extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: Constant.MATERIAL_APP_TITLE,
			theme: MacawTheme.primaryTheme,
			home: RootController(),
			debugShowMaterialGrid: false,
			showPerformanceOverlay: false,
			checkerboardRasterCacheImages: false,
			checkerboardOffscreenLayers: false,
			showSemanticsDebugger: false,
			debugShowCheckedModeBanner: false
		);
	}
}