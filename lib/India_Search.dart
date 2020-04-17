import 'package:flutter/material.dart';


class Search extends SearchDelegate{

  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query='';

      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
      Navigator.pop(context);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    final suggestionList
    =
    query.isEmpty?
    countryList:
    countryList.where((element) => element['state'].toString().toLowerCase().startsWith(query)).toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index){
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  isThreeLine: true,
                  title: Text(suggestionList[index]['state'],style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),),
                  subtitle: Text("Active Cases: " + suggestionList[index]['active'] + "\n" + "Confirmed Cases: " +suggestionList[index]['confirmed']),
                  trailing: Text("Deaths: " + suggestionList[index]['deaths'] + "\n" + "Recovered: " + suggestionList[index]['recovered']),
//                              trailing: Text(_death(snapshot.data[index]),style: TextStyle(fontSize: 15.0),),
                )
              ],
            ),
          )
          ;
        });
  }

}