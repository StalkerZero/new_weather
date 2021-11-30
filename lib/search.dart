import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'data.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchPage> createState() => _FavoritesPageState();
}

search(String text) async {
  final resp = await http.get(Uri.parse(
      'http://api.geonames.org/searchJSON?name_startsWith=$text&maxRows=10&orderby=relevance&username=stalkernidus'));
  // log(resp.body.toString());
  final respFromJson = jsonDecode(resp.body)['geonames'];
  // log(respFromJson.toString());
  // await data.start();
  data.cities.clear();
  for (int i = 0; i < 10; i++)
    data.cities.add(respFromJson[i]['name'].toString() +
        "," +
        respFromJson[i]['countryCode'].toString());
  // data.res.forEach((e) {print(e+"\n");});
}

class _FavoritesPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      data.cities.clear();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    iconSize: 25,),
                LimitedBox(
                  maxWidth: 300,
                  child: CupertinoSearchTextField(
                    itemSize: 22,
                    style: GoogleFonts.manrope(
                        fontSize: 17,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                    placeholder: "  Введите название города",
                    placeholderStyle: GoogleFonts.manrope(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    onSubmitted: (text) async {
                      await search(text);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
              // padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
              child: Visibility(
                visible: data.cities.length > 0,
                child: ListView(
                  padding: EdgeInsets.only(left: 20),
                  // itemExtent: 5,
                  children: data.cities
                      .map((e) => TextButton(
                          onPressed: () async {
                            await data.addCity(e);
                            await data.oneCall();
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(alignment: Alignment.centerLeft),
                          child: Text(
                              e,
                              style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  color: Theme.of(context).accentColor
                              )
                          )
                      )).toList(),
                ),
              ),
            ),
          ]),
        ),
      );
}
