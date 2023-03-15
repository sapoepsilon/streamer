import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String query;
  const Search({super.key, required this.query});

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
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchQuery: widget.query),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final String searchQuery;

  CustomSearchDelegate({required this.searchQuery});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = searchQuery;
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // we need parse are subsonic result
    List<String> matchquery = [];
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (context, index) {
        var result = matchquery[index];
        return ListTile(title: Text(result));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (context, index) {
        var result = matchquery[index];
        return ListTile(title: Text(result));
      },
    );
  }
}
