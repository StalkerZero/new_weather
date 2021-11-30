import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'data.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                      iconSize: 28,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Text('Настройки',
                        style: GoogleFonts.didactGothic(
                            fontSize: 30, fontWeight: FontWeight.w600))
                  ],
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Neumorphic(
                    padding: EdgeInsets.all(10),
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                      color: Colors.transparent,
                      depth: 4,
                      shadowLightColor: Colors.black,
                      lightSource: LightSource.bottom,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Тёмная тема',
                            style: GoogleFonts.manrope(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        NeumorphicSwitch(
                          style: NeumorphicSwitchStyle(
                            thumbDepth: 5,
                            trackDepth: -5,
                          ),
                          onChanged: (val) async {
                            await data.prefs.setBool("theme", val);
                            Get.changeThemeMode(data.prefs.getBool('theme')!
                                ? ThemeMode.dark
                                : ThemeMode.light);
                            setState(() {});
                          },
                          value: data.prefs.getBool("theme") ?? false,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80, left: 20, bottom: 15),
                  child: Text('Единицы измерения',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      )),
                ),
                Container(
                  height: 160,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      color: Colors.transparent,
                      depth: 4,
                      shadowLightColor: Colors.black,
                      lightSource: LightSource.bottom,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.all(Radius.circular(20))),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Температура',
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 110,
                              height: 27,
                              child: NeumorphicToggle(
                                style: NeumorphicToggleStyle(
                                  backgroundColor: Theme.of(context).accentColor,
                                  depth: 4,
                                  lightSource: LightSource.bottom,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    data.prefs.setInt("temp", val);
                                  });
                                },
                                selectedIndex: data.prefs.getInt("temp") ?? 0,
                                thumb: Container(color: Theme.of(context).canvasColor,),
                                children: [
                                  ToggleElement(
                                    background: Center(
                                      child: Text(
                                        '°C',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    foreground: Center(
                                      child: Text(
                                        '°С',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ToggleElement(
                                    background: Center(
                                      child: Text(
                                        '°F',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    foreground: Center(
                                      child: Text(
                                        '°F',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Сила ветра',
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: 110,
                              height: 27,
                              child: NeumorphicToggle(
                                style: NeumorphicToggleStyle(
                                  backgroundColor: Theme.of(context).accentColor,
                                  depth: 4,
                                  lightSource: LightSource.bottom,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    data.prefs.setInt("wind", val);
                                  });
                                },
                                selectedIndex: data.prefs.getInt("wind") ?? 0,
                                thumb: Container(color: Theme.of(context).canvasColor,),
                                children: [
                                  ToggleElement(
                                    background: Center(
                                      child: Text(
                                        'м/с',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    foreground: Center(
                                      child: Text(
                                        'м/с',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ToggleElement(
                                    background: Center(
                                      child: Text(
                                        'км/ч',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    foreground: Center(
                                      child: Text(
                                        'км/ч',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Давление',
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: 170,
                              height: 27,
                              child: NeumorphicToggle(
                                style: NeumorphicToggleStyle(
                                  backgroundColor: Theme.of(context).accentColor,
                                  depth: 4,
                                  lightSource: LightSource.bottom,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    data.prefs.setInt("press", val);
                                  });
                                },
                                selectedIndex: data.prefs.getInt("press") ?? 0,
                                thumb: Container(color: Theme.of(context).canvasColor,),
                                children: [
                                  ToggleElement(
                                    background: Center(
                                      child: Text(
                                        'гПа',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    foreground: Center(
                                      child: Text(
                                        'гПа',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ToggleElement(
                                    background: Center(
                                      child: Text(
                                        'мм.рт.ст',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    foreground: Center(
                                      child: Text(
                                        'мм.рт.ст',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                ),
              ),
            ),
          ])),
        ),
      );
}
