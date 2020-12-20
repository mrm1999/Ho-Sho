import 'package:DesiMartProto/screens/Buyer/HomeScreen.dart';
import 'package:flutter/material.dart';

class ProductSearch extends SearchDelegate<String> {
  List<String> list;
  String selectedString;
  ProductSearch() {
    list = [
      'strawberry cake',
      'butterScotch cake',
      'chocolate cake',
      'malai cake',
      'pineapple cake',
      'vanilla cake',
      'banana cake',
      'red velvet cake',
      'moong papad',
      'potato papad',
      'ragi papad',
      'rice papad',
      'garlic papad',
      'sabudana papad',
      'allspice',
      'anise',
      'cardamom',
      'cayene',
      'cinnamon',
      'cloves',
      'coriander',
      'cumin',
      'curry powder',
      'fennel speed',
      'garam masala',
      'ginger',
      'mace',
      'nutmeg',
      'turmeric',
      'paprika',
      'red ppice',
      'lemon pickle',
      'mango pickle',
      'cucumber pickle',
      'onion pickle',
      'tomato pickle',
      'garlic pickle',
      'green chilli pickle',
      'radish pickle',
      'bitter gourd pickle',
      'red chilli pickle',
      'capsicum pickle',
      'amla pickle'
    ];
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList;
    // this list will contain the suggestions
    if (query.isEmpty) {
      return ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text("You haven't entered anything..."),
            ),
          ),
        ],
      );
    } else {
      suggestionList = list.where((p) => p.startsWith(query)).toList();
      // suggestionList containing list of cities starting with the input query

      return ListView.builder(
        // This Widget will build the List
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 0.5),
          child: Card(
            elevation: 5.0,
            color: Colors.white.withOpacity(0.8),
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(),
            child: ListTile(
              onTap: () {
                selectedString = suggestionList[index];
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                // This function pushes the coordinates of selected city on next screen
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              subtitle: Text(
                suggestionList[index],
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              trailing: IconButton(
                  icon: Icon(
                    Icons.food_bank,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: null),
            ),
          ),
        ),
        itemCount: suggestionList.length,
      );
    }
  }
}
