
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Container(
        color: Color(0xFFE2EBFF),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    iconSize: 20,
                    color: Colors.black),
                SizedBox(
                  width: 18,
                ),
                Text('О разработчике',
                    style: GoogleFonts.manrope(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            color: Color(0xFFDEE9FF),
                            depth: -15,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(15)))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 32,
                          ),
                          child: Text('Weather app',
                              style: GoogleFonts.manrope(
                                  color: Color(0xFF000000),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Neumorphic(
                        padding: EdgeInsets.only(top: 23),
                        style: NeumorphicStyle(
                            color: Color(0xFFE2EBFF),
                            depth: 5,
                            lightSource: LightSource.bottom,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(28)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'by ITMO University',
                                  style: GoogleFonts.manrope(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),

                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Версия 1.0',
                                  style: GoogleFonts.manrope(
                                      color: Color(0xFF4A4A4A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'от 30 сентября 2021',
                                  style: GoogleFonts.manrope(
                                      color: Color(0xFF4A4A4A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Column(
                                children: [
                                  Text('2021',
                                      style: GoogleFonts.manrope(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
