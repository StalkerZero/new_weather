import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;
  static Set<String> strings = LinkedHashSet();

  @override
  State<SearchPage> createState() => _FavoritesPageState();
}

fetchData(Client client, String text) async{
  final resp = await client.get(Uri.parse('http://api.geonames.org/searchJSON?name_startsWith=$text&maxRows=5&orderby=relevance&username=oksik'));
  // log(resp.body.toString());
  final respDec = jsonDecode(resp.body)['geonames'];
  print(respDec.toString());
  SearchPage.strings.clear();
  for(int i=0; i<5; i++){
    SearchPage.strings.add(respDec[i]["name"]+', '+respDec[i]["countryName"]);
  }
}

class _FavoritesPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children:[
                Row(
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
                        onSubmitted: (text) async {
                          await fetchData(Client(), text);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                FutureBuilder( //Visibility
                    builder: (context, snapshot) {
                      if(SearchPage.strings.isNotEmpty) {
                        return ListView.builder(
                            itemExtent: 5,
                            itemBuilder: (contest, index) {
                              return ListTile(
                                title: Text(SearchPage.strings.toList()[index]),
                                onTap: () {},
                              );
                            }
                        );
                      }
                      else return Text("");
                    }
                ),
              ]
            ),
          ),
        ),
      );
}
