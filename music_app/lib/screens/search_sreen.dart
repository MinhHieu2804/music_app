import 'package:flutter/material.dart';
import 'package:music_app/providers/search.dart';
import 'package:music_app/widgets/search_result.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchFunction = Provider.of<Search>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              onChanged: (_) async {
                if (searchController.text == "") {
                  await Provider.of<Search>(context, listen: false)
                      .emptySearch();
                }
                await searchFunction.search(searchController.text);
              },
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Color(0xff282828),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 35,
                  ),
                  hintText: 'Artists or songs',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SearchResult(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
