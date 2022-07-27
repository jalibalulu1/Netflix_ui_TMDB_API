import 'package:flutter/material.dart';
import 'package:netflix_ui/pages/root_app.dart';
import 'package:netflix_ui/pages/search_page.dart';

void main() async{
  await getserachMovies();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RootApp(),
  ));
}
