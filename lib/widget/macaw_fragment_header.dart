import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MacawFragmentHeader extends StatelessWidget {

	final String _asset;
	final List<Color> _gradient;

	MacawFragmentHeader(this._asset, this._gradient);

	@override
	Widget build(BuildContext context) {
		return Container(
			height: 200.0,
			decoration: BoxDecoration(
				gradient: LinearGradient(
					begin: Alignment.topRight,
					end: Alignment.bottomLeft,
					colors: this._gradient
				),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				mainAxisAlignment: MainAxisAlignment.end,
				children: <Widget>[
					SvgPicture.asset(
						this._asset,
						height: 200.0,
						alignment: Alignment.bottomCenter,
					)
				],
			)
		);
	}
}