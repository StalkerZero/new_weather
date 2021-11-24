import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weather_icons/weather_icons.dart';
import 'data.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPage();
}

class _ForecastPage extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Column(
                      children: [
                        Text(
                          'Прогноз на неделю',
                          style: GoogleFonts.manrope(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Container(
                      height: 387,
                      width: 320,
                      child: Swiper(
                          itemHeight: 387,
                          itemWidth: 320,
                          itemCount: 7,
                          layout: SwiperLayout.STACK,
                          loop: false,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: data.prefs.getBool('theme')!? LinearGradient(colors: [
                                  Color(0xFF223b70),
                                  Color(0xFF102042),
                                ]) : LinearGradient(colors: [
                                  Color(0xFFCDDAF5),
                                  Color(0xFF9CBCFF),
                                ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        (23+index).toString()+" сентября", //TODO: Сделать реальную дату
                                        style: GoogleFonts.manrope(
                                            fontSize: 24,
                                            color: Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 0, bottom: 20),
                                      leading: Icon(
                                          WeatherIcons.rain,
                                          color: Theme.of(context).accentColor,
                                          size: 60)
                                    ),
                                    ListTile(
                                      leading: Icon(WeatherIcons.thermometer, size: 26,),
                                      title: Align(
                                        child: Text(
                                          data.temp("daily", index),
                                          style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        alignment: Alignment(-1.2, 0),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        WeatherIcons.strong_wind,
                                        color: Theme.of(context).accentColor,
                                        size: 26,),
                                      title: Align(
                                        child: Text(
                                          data.wind("daily", index),
                                          style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        alignment: Alignment(-1.22, 0),
                                      ),
                                    ),
                                    ListTile(
                                      leading:Icon(
                                        WeatherIcons.humidity,
                                        color: Theme.of(context).accentColor,
                                        size: 26,),
                                      title: Align(
                                        child: Text(
                                          data.prefs.getStringList("daily")![index].split(';')[2]+'%',
                                          style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        alignment: Alignment(-1.2, 0),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        WeatherIcons.barometer,
                                        color: Theme.of(context).accentColor,
                                        size: 26,),
                                      title: Align(
                                        child: Text(
                                          data.press("daily", index),
                                          style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        alignment: Alignment(-1.26, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Theme.of(context).accentColor, width: 1),
                      ),
                      child: Text(
                        "Вернуться на главную",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
