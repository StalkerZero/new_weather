import 'package:flutter/material.dart';
import 'data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                    iconSize: 28,
                    color: Theme.of(context).accentColor,),
                SizedBox(
                  width: 18,
                ),
                Text('Избранные',
                    style: GoogleFonts.didactGothic(
                        fontSize: 30,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Container(
              height: 500,
              child: Visibility(
                visible: data.prefs.getStringList('favorites')!=null,
                child: ListView(
                  padding: EdgeInsets.only(left: 20),
                  // itemExtent: 5,
                  children: data.prefs.getStringList('favorites')!.map((e) => TextButton(
                      onPressed: ()async{
                        data.prefs.setString('city', e);
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
          ],
        ),
      ),
    ),
  );
}
