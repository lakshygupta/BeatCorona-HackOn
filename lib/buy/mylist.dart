import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/api/auth_notifier.dart';
import 'package:flutternewsapp/buy/tabs.dart';
import 'package:flutternewsapp/model/lists.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';



class Mylist extends StatefulWidget {
  @override
  _MylistState createState() => _MylistState();
}

class _MylistState extends State<Mylist> {
  List<Listmy> buyinglist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    print('uSER '+ authNotifier.user.uid);
    final DBref = FirebaseDatabase.instance.reference().child('Users').child(authNotifier.user.uid).child("mylist");
    DBref.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      buyinglist.clear();

      for(var individualKey in KEYS)
      {
          Listmy my = new Listmy
          (
              quantity: DATA[individualKey]['quantity'],
              itemname: DATA[individualKey]['itemname'],
              type: DATA[individualKey]['type'],
        );
          buyinglist.add(my);
      }
      setState(() {
        print('buyinglist=$buyinglist.length');
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: new Container(
        child: buyinglist.length == 0?Center(
          child: new Text("All the added items will be shown here",style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20
          ),),
        ): new ListView.builder(
          itemCount: buyinglist.length,
          itemBuilder: (_,index)
          {
              return Postsui(buyinglist[index].quantity, buyinglist[index].itemname,buyinglist[index].type);
          }

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new TabBarDemo()));
          },
        ),
      ),
    );
  }

  Widget Postsui( String quantity,String itemname,String type)
  {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child:
        new Container(
      decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage("assets/card.jpg"),
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      )),
          padding :new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    itemname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),

                  new Text(
                    'Quantity = '+quantity,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                        color: Colors.white
                    ),
                  )

                ],
              ),
              SizedBox(height: 6.0),
              new Divider(
                color: Colors.blue,
                indent: 16.0,
              ),
              SizedBox(height: 10.0),
              new Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white
                ),
              )
            ],
          ),
        )
    );
  }
}
