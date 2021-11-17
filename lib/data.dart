import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class data{
  static Set<String> res = new Set();

  static late SharedPreferences prefs;

  static share() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('city')==null) prefs.setString('city', "Санкт Петербург,RU");
  }

  static addCity(String city) async {
    final resp = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=6c25cdf322855fb2b4f4a02837a136ed'));
    // print(resp.body.toString());
    if(jsonDecode(resp.body)['cod']==200){
      prefs.setString('city', city);
      Set<String> list = new Set();
      if(prefs.getStringList('favorites')!=null) list = prefs.getStringList('favorites')!.toSet();
      list.add(city);
      prefs.setStringList('favorites', list.toList());
      print("Success");
    }
  }


}