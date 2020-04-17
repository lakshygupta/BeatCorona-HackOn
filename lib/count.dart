import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'India_Search.dart';
class UserList extends StatelessWidget{
  List stateData;
  final String apiUrl = "https://api.covid19india.org/data.json";

  Future<List<dynamic>> fetchUsers() async {

    var result = await http.get(apiUrl);
    stateData = json.decode(result.body)['statewise'];
    return stateData;
  }

  String _name(dynamic user){

    return user['state'];
  }

  String _cases(dynamic user){
    return "Active Cases: " + user['active'] + "\n" + "Confirmed Cases: " + user['confirmed'];
  }
  String _death(dynamic user){
    return "Deaths: " + user['deaths'] + "\n" + "Recovered: " + user['recovered'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: () {
            showSearch(context: context, delegate: Search(stateData));
          },)
        ],
        title: Text('India Cases'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return
                      Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              isThreeLine: true,
                              title: Text(_name(snapshot.data[index]),style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),),
                              subtitle: Text(_cases(snapshot.data[index]),style: TextStyle(fontSize: 15.0),),
                              trailing: Text(_death(snapshot.data[index]),style: TextStyle(fontSize: 15.0),),
                            )
                          ],
                        ),
                      );
                  });
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },


        ),
      ),
    );
  }

}