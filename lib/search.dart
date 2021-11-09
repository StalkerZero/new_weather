import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchPage> createState() => _FavoritesPageState();
}

fetchData(Client client, String text) async{
  final resp = await client.get(Uri.parse('http://api.geonames.org/searchJSON?name_startsWith=$text&maxRows=10&orderby=relevance&username=oksik'));
  log(resp.body.toString());
  final respFromJson = jsonDecode(resp.body);
  respFromJson['geonames'][0];
  log(respFromJson.toString());
}

class _FavoritesPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    iconSize: 20,
                    color: Colors.black),
                LimitedBox(
                  maxWidth: 350,
                  child: CupertinoSearchTextField(
                    placeholder: "Введите название города",
                    onSubmitted: (text){
                      fetchData(Client(), text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
