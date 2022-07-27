import 'package:flutter/material.dart';

import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List nowplaying = [];

  final String apikey = '018cc897f0efd577dfafa7d78ccd906c';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMThjYzg5N2YwZWZkNTc3ZGZhZmE3ZDc4Y2NkOTA2YyIsInN1YiI6IjYyYTQ5NTc4ZDU1Njk3MThjODg1NDg3NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EmNyTOuWlv2hcVpYgk73_pO2rrJ6AvB-k4IWsj3Nuog';
  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    Map nowplayingresult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();

    setState(() {
      trendingmovies = trendingresult["results"];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
      nowplaying = nowplayingresult['results'];
      //  print(nowplaying);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                width: size.height - 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 500,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/banner.webp"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 500,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.85),
                              Colors.black.withOpacity(0)
                            ],
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                          )),
                        ),
                        SizedBox(
                          height: 500,
                          width: size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/title_img.webp",
                                width: 300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Exciting - Sci-Fi Drama - Sci-Fi Adventure",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "My List",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 13, left: 8, top: 2, bottom: 2),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.info_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Info",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Text(
                            "Top Rated Movies",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                                children: List.generate(topratedmovies.length,
                                    (index) {
                              return Container(
                                width: 110,
                                height: 160,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    // image: DecorationImage(
                                    //     image: NetworkImage(
                                    //         'https://image.tmdb.org/t/p/w500' +
                                    //             topratedmovies[index]
                                    //                 ['poster_path']),
                                    //     fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(6)),
                                    child: Image.network('https://image.tmdb.org/t/p/w500' +
                                                topratedmovies[index]
                                                    ['poster_path']),
                              );
                            })),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Text(
                            "Popular TV Show Movies",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                                children: List.generate(tv.length, (index) {
                              return Container(
                                width: 110,
                                height: 160,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${tv[index]['backdrop_path']}'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(6)),
                              );
                            })),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Text(
                            "Trending Now",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                                children: List.generate(trendingmovies.length,
                                    (index) {
                              return Container(
                                width: 110,
                                height: 160,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                trendingmovies[index]
                                                    ['poster_path']),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(6)),
                              );
                            })),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Text(
                            "Now Playing",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                                children:
                                    List.generate(nowplaying.length, (index) {
                              return Container(
                                width: 165,
                                height: 300,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                nowplaying[index]
                                                    ['backdrop_path']),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(6)),
                              );
                            })),
                          ),
                        )
                      ],
                    )
                  ],
                )),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset("assets/images/logo.ico",
                            width: 35, fit: BoxFit.cover),
                      ),
                      Row(
                        children: [
                          const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.collections_bookmark,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          IconButton(
                              onPressed: null,
                              icon: Image.asset(
                                'assets/images/profile.jpeg',
                                width: 26,
                                fit: BoxFit.cover,
                                height: 26,
                              ))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "TV Shows",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Movies",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: const [
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
