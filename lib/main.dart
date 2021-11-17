import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data.dart';
import 'develop.dart';
import 'favorites.dart';
import 'forecast.dart';
import 'settings.dart';
import 'search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      theme: ThemeData(
        canvasColor: Color(0xFFE2EBFF),
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home Page Light'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  static int weather = 2;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Icon weather(){
    switch(MyHomePage.weather) {
      case 1:
        return Icon(WeatherIcons.day_sunny);
      case 2:
        return Icon(WeatherIcons.rain);
      case 3:
        return Icon(WeatherIcons.cloud);
      case 4:
        return Icon(WeatherIcons.day_snow);
      default:
        return Icon(WeatherIcons.alien);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: Container(
      width: 223,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text('Weather app',
                      style: GoogleFonts.dancingScript(
                          fontSize: 35, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.settings),
                  const SizedBox(
                    width: 18,
                  ),
                  Text('Настройки',
                      style: GoogleFonts.didactGothic(fontSize: 23)),
                ],
              ),
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SettingsPage(title: 'Settings')));
                setState(() {});
              },
            ),
            ListTile(
              title: Row(children: [
                const Icon(Icons.favorite_border),
                const SizedBox(
                  width: 18,
                ),
                Text('Избранное', style: GoogleFonts.didactGothic(fontSize: 23)),
              ]),
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FavoritesPage(title: 'Favorites')));
                setState(() {});
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.account_circle_outlined),
                  const SizedBox(
                    width: 18,
                  ),
                  Text('О приложении',
                      style: GoogleFonts.didactGothic(fontSize: 23)),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DeveloperPage(title: 'About')));
              },
            ),
          ],
        ),
      ),
    ),
    body: FutureBuilder(
        future: data.start(),
        builder: (context, snapshot) {
      return ExpandableBottomSheet(
        background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data.theme()),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [
                const Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                          },
                        padding: EdgeInsets.only(top: 0),
                        child: Icon(Icons.menu, size: 45, color: Colors.white),
                        style: NeumorphicStyle(
                          depth: 3,
                          color: Colors.transparent,
                          lightSource: LightSource.bottom,
                          boxShape: NeumorphicBoxShape.circle(),
                        ),
                      ),
                      Text(data.prefs.getString('city')!,
                          style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      NeumorphicButton(
                        onPressed: ()async{
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SearchPage(title: 'Search')));
                          setState(() {});
                        },
                        padding: EdgeInsets.only(top: 0),
                        child: NeumorphicIcon(
                          Icons.add_circle_outline,
                          size: 45,
                          style: NeumorphicStyle(
                            depth: 10,
                            color: Colors.white,
                          ),
                        ),
                        style: NeumorphicStyle(
                          depth: 3,
                          color: Colors.transparent,
                          lightSource: LightSource.bottom,
                          boxShape: NeumorphicBoxShape.circle(),
                        ),
                      ),
                    ]),
                Text(
                    data.temp(),
                    style: GoogleFonts.manrope(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -5)
                ),
                Text(
                  data.date(),
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ])
        ),
        persistentHeader: Container(
            height: 40,
            width: 1000,
            color: Color(0xFFE2EBFF),
            child: Center(
              child: Container(
                height: 6,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
              ),
            ),
          ),
        persistentContentHeight: 150,
        expandableContent:
          Container(
            height: 380,
            color: Color(0xFFE2EBFF),
            child:
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(
                              color: Color(0xFFE2EBFF),
                              depth: 3,
                              lightSource: LightSource.top,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 6,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '06:00',
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: weather(),
                                  ),
                                  Text(
                                    data.temp(),
                                    style: GoogleFonts.manrope(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(
                              color: Color(0xFFE2EBFF),
                              depth: 3,
                              lightSource: LightSource.top,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 6,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '06:00',
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: weather(),
                                  ),
                                  Text(
                                    data.temp(),
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(
                              color: Color(0xFFE2EBFF),
                              depth: 3,
                              lightSource: LightSource.top,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 6,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '06:00',
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: weather(),
                                  ),
                                  Text(
                                    data.temp(),
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(
                              color: Color(0xFFE2EBFF),
                              depth: 3,
                              lightSource: LightSource.top,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 6,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '06:00',
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: weather(),
                                  ),
                                  Text(
                                    data.temp(),
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 165,
                            height: 90,
                            child:Neumorphic(
                              style: NeumorphicStyle(
                                color: Color(0xFFE2EBFF),
                                depth: 10,
                                lightSource: LightSource.top,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(WeatherIcons.thermometer, size: 26,),
                                  Text(
                                    data.temp(),
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 165,
                            height: 90,
                            child:Neumorphic(
                              style: NeumorphicStyle(
                                color: Color(0xFFE2EBFF),
                                depth: 10,
                                lightSource: LightSource.top,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(WeatherIcons.humidity, size: 26,),
                                  Text(
                                    data.prefs.getStringList("current")![2]+'%',
                                    style: GoogleFonts.manrope(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 165,
                        height: 90,
                        child:Neumorphic(
                          style: NeumorphicStyle(
                            color: Color(0xFFE2EBFF),
                            depth: 10,
                            lightSource: LightSource.top,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(WeatherIcons.strong_wind, size: 26,),
                              Text(
                                data.wind(),
                                style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 165,
                        height: 90,
                        child:Neumorphic(
                          style: NeumorphicStyle(
                            color: Color(0xFFE2EBFF),
                            depth: 10,
                            lightSource: LightSource.top,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(WeatherIcons.barometer, size: 26,),
                              Text(
                                data.press(),
                                style: GoogleFonts.manrope(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ],
              ),
          ),
        persistentFooter:
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: BorderSide(color: Color(0xFF038CFE), width: 1),
                ),
                child: Text(
                  "Прогноз на неделю",
                  style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Color(0xFF038CFE),
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ForecastPage()));
                },
              ),
            ),
          ),
      );
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(30),
        //   topRight: Radius.circular(30),
        // ),
    }),
  );
}