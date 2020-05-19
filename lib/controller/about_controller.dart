import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macaw/presentation/swan_icons.dart';
import 'package:macaw/service/constant.dart';
import 'package:macaw/service/macaw_palette.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends StatelessWidget {

	@override
	build(BuildContext context) {
		return Scaffold(
			body: SingleChildScrollView(
				padding: EdgeInsets.only(
					top: 100.0,
					bottom: 100.0,
					left: 15.0,
					right: 15.0
				),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: Text(
								Constant.MACAW,
								textAlign: TextAlign.center,
								style: GoogleFonts.changa(
									textStyle: TextStyle(
										fontSize: 45.0,
										color: MacawPalette.accentColor,
										fontWeight: FontWeight.bold,
										letterSpacing: 3.0
									)
								),
							),
						),
						Container(
							padding: EdgeInsets.all(0.0),
							alignment: Alignment.center,
							child: Text(
								Constant.KU,
								textAlign: TextAlign.center,
								style: GoogleFonts.changa(
									textStyle: TextStyle(
										fontSize: 20.0,
										color: MacawPalette.darkBlue,
										fontWeight: FontWeight.w400,
									)
								),
							),
						),
						Container(
							padding: EdgeInsets.all(0.0),
							alignment: Alignment.center,
							child: Text(
								Constant.CSE,
								textAlign: TextAlign.center,
								style: GoogleFonts.changa(
									textStyle: TextStyle(
										fontSize: 18.0,
										color: MacawPalette.greyTintD,
										fontWeight: FontWeight.w300,

									)
								),
							),
						),
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: RichText(
								textAlign: TextAlign.center,
								text: TextSpan(
									children: <TextSpan>[
										TextSpan(
											text: "Please note that all document / data available here has been compiled from several sources which have been properly linked and referenced to. All information available here is being continuously "
												"updated as and when available. If you find any discrepancy or false data / information here, kindly write to us at\n",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										),
										TextSpan(
											text: " " + Constant.CONTACT_EMAIL + " ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: Colors.white,
													fontWeight: FontWeight.bold,
													backgroundColor: MacawPalette.green,
													wordSpacing: 3.0
												)
											),
											recognizer: TapGestureRecognizer()..onTap = () async {
												if(await canLaunch(Constant.MAILTO_URL))
													await launch(Constant.MAILTO_URL);
											}
										),
									]
								),
							),
						),
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: RichText(
								textAlign: TextAlign.justify,
								text: TextSpan(
									children: <TextSpan>[
										TextSpan(
											text: "Department of Computer Science along with Department of Statistics, University of Kalyani, has taken this initiative to develop an interactive site to view and interact with the daily available "
												"nCoV-2019 pandemic from various sources. The timeseries data available from various sources are used, especially for students, researchers, data analysts, data engineers and other experts to create "
												"interactive graphs, charts and plots to visualize the progress of different regions of India, and / or different countries around the globe and also to understand how various countries and / or regions within India are comparing against one another while fighting against this deadly disease.",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										)
									]
								),
							),
						),
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: RichText(
								textAlign: TextAlign.justify,
								text: TextSpan(
									children: <TextSpan>[
										TextSpan(
											text: "It is important to inform that we maintain our own datasets for the Indian subcontinent. Our team works tirelessly to update the dataset daily by collecting data from various reputable sources, "
												"tallying them, and maintaining timeseries datasets as truthful as possible. We have written a few scripts and developed a few tools in order to achieve this. All datasets, tools, scripts and further information about this is available ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										),
										TextSpan(
											text: " here ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: Colors.white,
													fontWeight: FontWeight.bold,
													backgroundColor: MacawPalette.green,
													wordSpacing: 3.0
												)
											),
											recognizer: TapGestureRecognizer()..onTap = () async {
												if(await canLaunch(Constant.GITHUB_KU_DATASET_URL))
													await launch(Constant.GITHUB_KU_DATASET_URL);
											}
										),
										TextSpan(
											text: ". You can also view individual dataset sources in the Datasets section of the app.",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										),
									]
								),
							),
						),
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: RichText(
								textAlign: TextAlign.justify,
								text: TextSpan(
									children: <TextSpan>[
										TextSpan(
											text: "Kindy bear in mind that this is ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										),
										TextSpan(
											text: " in no way, an effort to show the latest updated progress daily data. ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.redTintB,
													fontWeight: FontWeight.bold,
													wordSpacing: 3.0
												)
											),
										),
										TextSpan(
											text: " Even though our dataset and our process of updating the data may provide you with the most recent changes, we urge you to follow ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										),
										TextSpan(
											text: " covid19india.org ",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: Colors.white,
													fontWeight: FontWeight.bold,
													backgroundColor: MacawPalette.green,
													wordSpacing: 3.0
												)
											),
											recognizer: TapGestureRecognizer()..onTap = () async {
												if(await canLaunch("https://www.covid19india.org/"))
													await launch("https://www.covid19india.org/");
											}
										),
										TextSpan(
											text: " site for that, since they are doing an excellent work as a crowdsourced initiative. A major portion of our data update task depend on their dataset as well.",
											style: GoogleFonts.abel(
												textStyle: TextStyle(
													fontSize: 16.0,
													color: MacawPalette.greyTintD,
													fontWeight: FontWeight.bold
												)
											)
										),
									]
								),
							),
						),
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: Text(
								"#StayHome #StaySafe",
								textAlign: TextAlign.center,
								style: GoogleFonts.changa(
									textStyle: TextStyle(
										fontSize: 20.0,
										color: MacawPalette.accentColor,
										fontWeight: FontWeight.w400,
									)
								),
							),
						),
						Container(
							padding: EdgeInsets.all(10.0),
							alignment: Alignment.center,
							child: Text(
								"We stand with everyone fighting in the frontlines",
								textAlign: TextAlign.center,
								style: GoogleFonts.caveat(
									textStyle: TextStyle(
										fontSize: 25.0,
										color: MacawPalette.primaryColor,
										fontWeight: FontWeight.w600,
									)
								),
							),
						),
						Container(
							padding: EdgeInsets.only(
								top: 30.0,
								bottom: 8.0
							),
							alignment: Alignment.center,
							child: GestureDetector(
								child: Icon(
									SwanIcons.github,
									color: MacawPalette.darkYellow,
									size: 50.0,
								),
								onTap: () async {
									if(await canLaunch(Constant.GITHUB_PROJECT_URL))
										await launch(Constant.GITHUB_PROJECT_URL);
								},
							),
						),
						Container(
							padding: EdgeInsets.all(0.0),
							alignment: Alignment.center,
							child: GestureDetector(
								child: Text(
									" This Project is Open-Sourced on GitHub ",
									textAlign: TextAlign.center,
									style: GoogleFonts.robotoMono(
										textStyle: TextStyle(
											fontSize: 13.0,
											color: Colors.white,
											fontWeight: FontWeight.w600,
											backgroundColor: MacawPalette.darkBlue
										)
									),
								),
								onTap: () async {
									if(await canLaunch(Constant.GITHUB_PROJECT_URL))
										await launch(Constant.GITHUB_PROJECT_URL);
								},
							),
						),
					],
				),
			),
		);
	}
}