import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
          ),
        ],
      ),
      body: Center(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.purple, Colors.teal])))),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> playlist = [
    'The End of the Line - The Traveling Wilburys',
    'Fight for Your Right - Beastie Boys',
    'B is for Brutus - The Hives',
    'Work Hard, Play Hard - Wiz Khalifa',
    'Africa - Toto',
    'Young Blood - The Naked and Famous',
    'Time for Me to Fly - REO Speedwagon',
    'Howlin for You - The Black Keys',
    'Live and Let Die - Guns N Roses',
    'Radioactive - Imagine Dragons',
    'One Foot - WALK THE MOON',
    'The High Road - Broken Bells',
    'The Rent I Pay - Spoon',
    'Lightning Crashes - Live',
    'Lake Michigan - Rogue Wave',
    'Choker - twenty one pilots',
    'Big Sur - Jack Johnson',
    'High School Never Ends - Bowling for Soup',
    'Apologize - grandson',
    'Wake Me Up - Avicii'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in playlist) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in playlist) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
            tileColor: Colors.teal,
          );
        });
  }
}
