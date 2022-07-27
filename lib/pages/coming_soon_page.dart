// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}


  List comingSoon=[];


class _ComingSoonPageState extends State<ComingSoonPage> {

  @override
  void initState() {
    getMovies();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Coming Soon",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.collections_bookmark,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/profile.jpeg",
              width: 26,
              height: 26,
              fit: BoxFit.cover,
            ),
          )
        ]);
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 28,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9)),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 22,
              color: Colors.white.withOpacity(0.9),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        
        child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
             List.generate(comingSoon.length, (index) {
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage("https://image.tmdb.org/t/p/w500${comingSoon[index]["backdrop_path"]}"
                                          ))),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2)),
                            ),
                          ],
                        ),
                      ),
                     
                         
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network('https://image.tmdb.org/t/p/w500${comingSoon[index]["poster_path"]}'
                            ,
                              width: 120,
                            ),
                            Flexible(child: Text("${comingSoon[index]["overview"]}",style: const TextStyle(color: Colors.white),))
                            
                          ],
                        ),
                      )
                      ,const SizedBox(height:20 ,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Text("Releasing on ${comingSoon[index]['release_date']}",style: TextStyle(color: Colors.white.withOpacity(0.5),)),
                        
                      ),const SizedBox(height:15 ,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Text("${comingSoon[index]["title"]}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                       
                        
                      ),
                      const SizedBox(height:5 ,),
                  
      
      
                    ]),
              );
            })),
      )
    ]));
  }
  Future <List> getMovies()async{
    final response=await http.get(Uri.parse("https://api.themoviedb.org/3/movie/now_playing?api_key=018cc897f0efd577dfafa7d78ccd906c&language=en-US&page=1;"));
    final fetchedData=await jsonDecode(response.body);
    setState(() {
      
      comingSoon=fetchedData["results"];
    });
     

    return comingSoon;
  }
}
