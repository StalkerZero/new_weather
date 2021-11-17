import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class data{
  static Set<String> res = new Set();

  static late SharedPreferences prefs;

  static share() async {
    return prefs = await SharedPreferences.getInstance();
  }

  static addCity(String city) async {
    final resp = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=6c25cdf322855fb2b4f4a02837a136ed'));
    // print(resp.body.toString());
    if(jsonDecode(resp.body)['cod']==200){
      prefs.setString('city', city);
      List<String> list = [];
      if(prefs.getStringList('favorites')!=null) list = prefs.getStringList('favorites')!;
      list.add(city);
      prefs.setStringList('favorites', list);
      print("Success");
    }
  }
}