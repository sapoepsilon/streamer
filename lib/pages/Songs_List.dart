import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsList();
}

class _SongsList extends State<SongsList> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double HeightS = MediaQuery.of(context).size.height;
    final double WidthS = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            iconSize: 50,
            unselectedItemColor: Color.fromARGB(255, 137, 11, 11),
            selectedItemColor: Colors.green[700],
            currentIndex: 2,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music), label: "Library"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Library")
            ]),
        backgroundColor: Color.fromARGB(148, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          elevation: 0.0,
          title: Text(
            "Your Songs (draft)",
          ),
        ),
        body: FutureBuilder<String>(
          future:
              DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
          // future: rootBundle.loadString("AssetManifest.json")
          builder: (context, item) {
            if (item.hasData) {
              Map? jsonMap = json.decode(item.data!);
              // List? songs = jsonMap?.keys.toList();
              List? songs = jsonMap?.keys
                  .where((element) => element.endsWith(".mp3"))
                  .toList();

              return ListView.builder(
                itemCount: songs?.length,
                itemBuilder: (context, index) {
                  var path = songs![index].toString();
                  var title = path.split("/").last.toString();
                  title = title.replaceAll("%20", "");
                  title = title.split(".").first;

                  return Container(
                    margin: const EdgeInsets.only(
                        top: 0.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(185, 21, 40, 54),
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.download),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      textColor: Color.fromARGB(204, 11, 170, 14),
                      title: Text(
                        title,
                      ),
                      subtitle:
                          Text("path: ${path.substring(13, path.length - 4)}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12.0,
                              )),
                      leading: Image.asset(
                        "assets/pato2.png",
                      ),
                      onTap: () async {
                        final snackBar = SnackBar(
                          content: Text(title),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // await player.setSourceAsset(path.substring(13));
                        // await player.play(
                        //     AssetSource("${(songs[index]).substring(13)}"));
                        // print((songs[index]).substring(13));
                        await _player.setAsset(path);
                        await _player.play();
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Songs Found"));
            }
          },
        ));
  }
}
