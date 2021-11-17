import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

class data{
  static Set<String> res = new Set();

  static late SharedPreferences prefs;

  static start() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('city')==null) {
      prefs.setString('city', "Санкт Петербург,RU");
    //  https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
    }
    if(prefs.getInt("temp")==null)prefs.setInt('temp', 0);
    if(prefs.getInt("wind")==null)prefs.setInt('wind', 0);
    if(prefs.getInt("press")==null)prefs.setInt('press', 0);

    currentWeather();
    dailyHourly();
    return;
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

  static currentWeather()async{
    final city = prefs.getString('city');
    final resp = jsonDecode((await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=6c25cdf322855fb2b4f4a02837a136ed'))).body);
    List<String> list = [];
    list.add(resp['main']["temp"].toString());
    list.add(resp['main']["pressure"].toString());
    list.add(resp['main']["humidity"].toString());
    list.add(resp['wind']["speed"].toString());
    prefs.setStringList('current', list);
  }

  static dailyHourly() async {
    final city = prefs.getString('city');
    final resp = jsonDecode((await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=6c25cdf322855fb2b4f4a02837a136ed'))).body)['list'];
    List<String> list = [];
    list.add(resp[0]['dt_txt'].toString());
    // formatDate(DateTime.parse(resp[0]['dt_txt']), [HH, ':', nn]);
    for(int i=0; i<7; i+=2) list.add(resp[i]['main']['temp'].toString());
    prefs.setStringList('hourly', list);
  }

  static String date(){
    return formatDate(DateTime.now(), [dd, ' ', M, ' ', yyyy]);
  }

  static hourlyTemp(int num){
    var temp = prefs.getStringList("hourly")![num];
    if(data.prefs.getInt("temp") !=1 )return double.parse(temp).toInt().toString()+"°C";
    return (double.parse(temp)*9~/5+32).toString()+"°F";
  }

  static time(int num){
    num--;
    var time = prefs.getStringList("hourly")![0].split(" ")[1].split(":");
    int buff = int.parse(time[0])+num*6;
    if(buff>=24) buff-=24;
    time[0]=buff.toString();
    time.removeAt(2);
    return time.join(":");
  }

  static String temp(){
    var temp = prefs.getStringList("current")![0];
    if(data.prefs.getInt("temp") !=1 )return double.parse(temp).toInt().toString()+"°C";
    return (double.parse(temp)*9~/5+32).toString()+"°F";
  }

  static String wind(){
    var speed = prefs.getStringList("current")![3];
    if(data.prefs.getInt("wind") !=1 )return '  '+speed+'м/с';
    return '  '+(double.parse(speed)*3.6).toString()+'км/ч';
  }

  static String press(){
    var press = prefs.getStringList("current")![1];
    if(data.prefs.getInt("press") !=1 )return press+'гПа';
    return (int.parse(press)~/(1+1/3)).toString()+'мм.рт.ст';
  }

  static String theme(){
    if(data.prefs.getBool("theme") == null) return 'assets/LightTheme.png';
    if(data.prefs.getBool("theme")!)return 'assets/DarkTheme.png';
    return 'assets/LightTheme.png';
  }



}