
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          color: Color(0xFFE2EBFF),
          child: Column(children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                    iconSize: 28,
                    color: Colors.black),
                SizedBox(
                  width: 18,
                ),
                Text('Настройки',
                    style: GoogleFonts.didactGothic(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Container(height: 20,),
            Container(
              height: 40,
              width: 360,
              child: Neumorphic(
                style: NeumorphicStyle(
                  depth: 3,
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Тёмная тема',
                        style: GoogleFonts.manrope(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)
                    ),
                    NeumorphicSwitch(
                      onChanged: (val){
                        setState(() {
                          MyApp.prefs.setBool("theme", val);
                        });
                      },
                      value: MyApp.prefs.getBool("theme") ?? false,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(top: 42, left: 20)),
                Text('Единицы измерения',
                    style: GoogleFonts.manrope(
                        color: Color(0xFF828282),
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            FutureBuilder(
              future: MyApp.share(),
              builder: (context, snapshot) {
                return Container(
                  height: 160,
                  width: 360,
                  child: Neumorphic(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Температура',
                                    style: GoogleFonts.manrope(
                                        color: Color(0xFF333333),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),

                                  ),
                                  SizedBox(
                                    width: 110,
                                    height: 27,
                                    child: NeumorphicToggle(
                                      onChanged: (val){
                                        setState(() {
                                          MyApp.prefs.setInt("temp", val);
                                        });
                                      },
                                      selectedIndex: MyApp.prefs.getInt("temp") ?? 0,
                                      thumb: Container(
                                        color: Color(0xFF4B5F88),
                                      ),
                                      children: [
                                        ToggleElement(
                                          background: Center(
                                            child: Text(
                                              '°C',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          foreground: Center(
                                            child: Text(
                                              '°С',
                                              style: TextStyle(
                                                color: Colors.white,
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
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          foreground: Center(
                                            child: Text(
                                              '°F',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      style: NeumorphicToggleStyle(
                                        backgroundColor: Colors.transparent,
                                        lightSource: LightSource.bottom,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
                              child: Divider(
                                height: 1,
                                color: Color(0xFFC6CEE3),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Сила ветра',
                                    style: GoogleFonts.manrope(
                                        color: Color(0xFF333333),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),

                                  ),
                                  Container(
                                    width: 110,
                                    height: 27,
                                    child: NeumorphicToggle(
                                      onChanged: (val){
                                        setState(() {
                                          MyApp.prefs.setInt("wind", val);
                                        });
                                      },
                                      selectedIndex: MyApp.prefs.getInt("wind") ?? 0,
                                      thumb: Container(
                                        color: Color(0xFF4B5F88),
                                      ),
                                      children: [
                                        ToggleElement(
                                          background: Center(
                                            child: Text(
                                              'м/с',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          foreground: Center(
                                            child: Text(
                                              'м/с',
                                              style: TextStyle(
                                                color: Colors.white,
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
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          foreground: Center(
                                            child: Text(
                                              'км/ч',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      style: NeumorphicToggleStyle(
                                        backgroundColor: Colors.transparent,
                                        lightSource: LightSource.bottom,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
                              child: Divider(
                                height: 1,
                                color: Color(0xFFC6CEE3),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Давление',
                                    style: GoogleFonts.manrope(
                                        color: Color(0xFF333333),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),

                                  ),
                                  Container(
                                    width: 170,
                                    height: 27,
                                    child: NeumorphicToggle(
                                      onChanged: (val){
                                        setState(() {
                                          MyApp.prefs.setInt("press", val);
                                        });
                                      },
                                      selectedIndex: MyApp.prefs.getInt("press") ?? 0,
                                      thumb: Container(
                                        color: Color(0xFF4B5F88),
                                      ),
                                      children: [
                                        ToggleElement(
                                          background: const Center(
                                            child: Text(
                                              'мм.рт.ст',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          foreground: const Center(
                                            child: Text(
                                              'мм.рт.ст',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ToggleElement(
                                          background: const Center(
                                            child: Text(
                                              'гПа',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          foreground: Center(
                                            child: Text(
                                              'гПа',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      style: NeumorphicToggleStyle(
                                        backgroundColor: Colors.transparent,
                                        lightSource: LightSource.bottom,
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
                    style: NeumorphicStyle(
                      color: Color(0xFFE2EBFF),
                      depth: 3,
                      lightSource: LightSource.top,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                );
              },
            ),
          ])),
    ),
  );
}