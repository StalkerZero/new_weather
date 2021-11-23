import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

class data{
  static Set<String> cities = new Set();

  static late SharedPreferences prefs;

  static start() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('city')==null)prefs.setString('city', "Санкт Петербург,RU;60.0;30.0");
    if(prefs.getInt("temp")==null)prefs.setInt('temp', 0);
    if(prefs.getInt("wind")==null)prefs.setInt('wind', 0);
    if(prefs.getInt("press")==null)prefs.setInt('press', 0);
    if(prefs.getBool("theme")==null)prefs.setBool('theme', false);

    oneCall();
    return;
  }

  static addCity(String city) async {
    final resp = jsonDecode((await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=6c25cdf322855fb2b4f4a02837a136ed'))).body);
    // print(resp.body.toString());
    if(resp['cod']==200){
      city+=';'+resp["coord"]["lat"].toString()+';'+resp["coord"]["lon"].toString();
      prefs.setString('city', city);
      Set<String> list = new Set();
      if(prefs.getStringList('favorites')!=null) list = prefs.getStringList('favorites')!.toSet();
      list.add(city);
      prefs.setStringList('favorites', list.toList());
      print("Success");
    }
  }

  static oneCall()async{
    final lat = prefs.getString('city')!.split(';')[1];
    final lon = prefs.getString('city')!.split(';')[2];
    final resp = jsonDecode((await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&units=metric&appid=6c25cdf322855fb2b4f4a02837a136ed'))).body);

    List<String> list = [];
    list.add(resp['current']['temp'].toString());
    list.add(resp['current']['pressure'].toString());
    list.add(resp['current']['humidity'].toString());
    list.add(resp['current']['wind_speed'].toString());
    await prefs.setStringList('current', list);

    list.clear();
    list.add(formatDate(DateTime.now(), [HH])+":00:00");
    for(int i=0; i<19; i+=6) list.add(resp['hourly'][i]['temp'].toString());
    await prefs.setStringList('hourly', list);

    list.clear();
    for(int i=0; i<7; i++) {
        list.add(
                resp['daily'][i]['temp']["day"].toString()+";"+
                resp['daily'][i]['pressure'].toString()+";"+
                resp['daily'][i]['humidity'].toString()+";"+
                resp['daily'][i]['wind_speed'].toString()
        );
      }
    await prefs.setStringList('daily', list);
  }

  static String date(){
    return formatDate(DateTime.now(), [dd, ' ', M, ' ', yyyy]);
  }

  static time(int num){
    num--;
    var time = prefs.getStringList("hourly")![0].split(":");
    int buff = int.parse(time[0])+num*6;
    if(buff>=24) buff-=24;
    time[0]=buff.toString();
    time.removeAt(2);
    return time.join(":");
  }

  static String temp(String str, int num){
    var temp;
    if(str=="daily")temp = prefs.getStringList(str)![num].split(';')[0];
    else temp = prefs.getStringList(str)![num];

    if(data.prefs.getInt("temp") !=1 )return double.parse(temp).toInt().toString()+"°C";
    return (double.parse(temp)*9~/5+32).toString()+"°F";
  }

  static String press(String str, int num){
    var press;
    if(str=="daily") press = prefs.getStringList(str)![num].split(';')[1];
    else press = prefs.getStringList(str)![num];

    if(data.prefs.getInt("press") !=1 )return press+'гПа';
    return (int.parse(press)~/(1+1/3)).toString()+'мм.рт.ст';
  }

  static String wind(String str, int num){
    var speed;
    if(str=="daily") speed = prefs.getStringList(str)![num].split(';')[3];
    else speed = prefs.getStringList(str)![num];

    if(data.prefs.getInt("wind") !=1 )return '  '+speed+'м/с';
    return '  '+(double.parse(speed)*3.6).toStringAsFixed(2)+'км/ч';
  }

  static String theme(){
    if(data.prefs.getBool("theme") == null) return 'assets/LightTheme.png';
    if(data.prefs.getBool("theme")!)return 'assets/DarkTheme.png';
    return 'assets/LightTheme.png';
  }

// static currentWeather()async{
//   final city = prefs.getString('city');
//   final resp = jsonDecode((await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=6c25cdf322855fb2b4f4a02837a136ed'))).body);
//   List<String> list = [];
//   list.add(resp['main']["temp"].toString());
//   list.add(resp['main']["pressure"].toString());
//   list.add(resp['main']["humidity"].toString());
//   list.add(resp['wind']["speed"].toString());
//   prefs.setStringList('current', list);
// }
//
// static hourly() async {
//   final city = prefs.getString('city');
//   final resp = jsonDecode((await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=6c25cdf322855fb2b4f4a02837a136ed'))).body)['list'];
//   List<String> list = [];
//   list.add(resp[0]['dt_txt'].toString().split(" ")[1]);
//   for(int i=0; i<7; i+=2) list.add(resp[i]['main']['temp'].toString());
//   prefs.setStringList('hourly', list);
// }

// static hourlyTemp(int num){
//   var temp = prefs.getStringList("hourly")![num];
//   if(data.prefs.getInt("temp") !=1 )return double.parse(temp).toInt().toString()+"°C";
//   return (double.parse(temp)*9~/5+32).toString()+"°F";
// }
}