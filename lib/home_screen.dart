import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mcu_api/Models/mcu_models.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var marvelApiUrl = "https://mcuapi.herokuapp.com/api/v1/movies";
  List<McuModels> mcuMoviesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarvelMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Movies App",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: mcuMoviesList.isNotEmpty
          ? GridView.builder(
              itemCount: mcuMoviesList.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: mcuMoviesList[index].coverUrl.toString(),
                    placeholder: (context, url) => Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2R0p5W-pI-ImF0BqJGIEMN-D6Eyxoc3M_9ARKGhb-64ML4xx-LGgxUd_goex0EwlDfTY&usqp=CAU'),
                  ),
                );
              },
            )
          : Center(
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white70,
                )),
              ),
            ),
    );
  }

  void getMarvelMovies() {
    debugPrint('=======Function running=======');
    final uri = Uri.parse(marvelApiUrl);
    http.get(uri).then((response) {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedData = jsonDecode(responseBody);
        final List marvelData = decodedData['data'];
        for (var i = 0; i < marvelData.length; i++) {
          final mcuMovie =
              McuModels.fromJson(marvelData[i] as Map<String, dynamic>);
          mcuMoviesList.add(mcuMovie);
        }
        setState(() {});
      } else {}
    }).catchError((err) {
      debugPrint('=======$err=======');
    });
  }
}
