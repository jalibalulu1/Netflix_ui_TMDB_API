import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:netflix_ui/movies/movies.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  // void initState() {
    
  //  // getData();
  //   super.initState();

  // }
  // getData()async{
  //   await getserachMovies();
  // }
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
      title: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Top Searches',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                  children: List.generate(data.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: (size.width - 36) * 0.8,
                          height: 80,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${data[index].backdropPath!}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: (size.width - 36) * 0.4,
                                  child: Text(
                                    data[index].title!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: (size.width - 36) * 0.2,
                          height: 80,
                          child: Center(
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: const Center(
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
              }))
            ])));
  }
  
}
List <Movies> data=[];
  Future getserachMovies()async{
    final response=await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=018cc897f0efd577dfafa7d78ccd906c&language=en-US&page=1;"));
    if(response.statusCode==200){
    final fetchedData=await jsonDecode(response.body);
    
Iterable map = fetchedData["results"];

   data= map.map((element) => Movies.fromJson(element)).toList();
 
  }
 
}