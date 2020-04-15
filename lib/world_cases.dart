import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserList1 extends StatelessWidget{

  final String apiUrl = "https://api.covid19api.com/summary";

  Future<List<dynamic>> fetchUsers() async {

    http.Response result = await http.get(apiUrl);
    return json.decode(result.body)['Countries'];

  }

  String _name(dynamic user){

    return user['Country'];
  }

  int _cases(dynamic user){
//    var val = ${};
    return user['NewConfirmed'];
  }
  int _confirmc(dynamic user){
//    var val = ${};
    return user['TotalConfirmed'];
  }
  int _ndeaths(dynamic user){
//    var val = ${};
    return user['NewDeaths'];
  }
  int _tdeaths(dynamic user){
//    var val = ${};
    return user['TotalDeaths'];
  }
//  String _death(dynamic user){
////    return "Deaths: " + user['TotalDeaths'] + "\n" + "Recovered: " + user['NewRecovered'];
////  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Cases'),
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
                              subtitle: Text("Active Cases: " + _cases(snapshot.data[index]).toString() + "\n" + "Confirmed Cases: " + _confirmc(snapshot.data[index]).toString()),
                              trailing: Text("Deaths: " + _ndeaths(snapshot.data[index]).toString() + "\n" + "Recovered: " + _tdeaths(snapshot.data[index]).toString()),
//                              trailing: Text(_death(snapshot.data[index]),style: TextStyle(fontSize: 15.0),),
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