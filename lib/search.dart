import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'data.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchPage> createState() => _FavoritesPageState();
}

search(Client client, String text) async{
  final resp = await client.get(Uri.parse('http://api.geonames.org/searchJSON?name_startsWith=$text&maxRows=10&orderby=relevance&username=stalkernidus'));
  // log(resp.body.toString());
  final respFromJson = jsonDecode(resp.body)['geonames'];
  data.res.clear();
  for(int i=0; i<10; i++) data.res.add(respFromJson[i]['name'].toString()+","+respFromJson[i]['countryCode'].toString());
  // data.res.forEach((e) {print(e+"\n");});
}

class _FavoritesPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          data.res.clear();
                          Navigator.pop(context);
                          },
                        icon: Icon(Icons.arrow_back_ios_outlined),
                        iconSize: 20,
                        color: Colors.black),
                    LimitedBox(
                      maxWidth: 350,
                      child: CupertinoSearchTextField(
                        placeholder: "Введите название города",
                        onSubmitted: (text) async {
                          await search(Client(), text);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: Visibility(
                    visible: data.res.length>0,
                    child: ListView(
                      // itemExtent: 5,
                      children: data.res.map((e) => TextButton(
                          onPressed: () {
                              data.addCity(e);
                              data.res.clear();
                              data.currentWeather();
                              Navigator.pop(context);
                            },
                          style: ButtonStyle(),
                          child:
                          Text(
                              e,
                              style: GoogleFonts.manrope(fontSize: 16)
                          )
                      )).toList(),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      );
}
