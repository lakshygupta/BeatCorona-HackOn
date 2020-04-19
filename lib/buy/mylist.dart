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
  bool isLoading  = true;
  void showAlert(context,String key,String itemname)
  {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);


      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.pop(context);
        onPress(key);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(itemname),
      content: Text("Do you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onPress(String key)
  {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    final DBref = FirebaseDatabase.instance.reference().child('Users').child(authNotifier.user.uid).child("mylist");
    print('pressed $key');
    DBref.child(key).remove();
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
            new Mylist()));

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    print('uSER '+ authNotifier.user.uid);
    final DBref = FirebaseDatabase.instance.reference().child('Users').child(authNotifier.user.uid).child("mylist");
    DBref.once().then((DataSnapshot snap) {

      if(snap.value!=null) {
        var KEYS = snap.value.keys;
        var DATA = snap.value;
        buyinglist.clear();

        for (var individualKey in KEYS) {
          Listmy my = new Listmy
            (
            quantity: DATA[individualKey]['quantity'],
            itemname: DATA[individualKey]['itemname'],
            type: DATA[individualKey]['type'],
            key: individualKey,
          );
          buyinglist.add(my);
        }

        setState(() {
          print('buyinglist=$buyinglist.length');
          isLoading = false;
        });

      }
      else
      {
      print("checked");
      setState(() {
        isLoading = false;
      });
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: new Container(
        child: isLoading ? Center( child: CircularProgressIndicator(),): buyinglist.length == 0? Center(
    child: new Text("All the added items will be shown here",style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20
    ),)) : new ListView.builder(
          itemCount: buyinglist.length,
          itemBuilder: (_,index)
          {
              print('key==='+buyinglist[index].key);
              return Postsui(buyinglist[index].quantity, buyinglist[index].itemname,buyinglist[index].type,buyinglist[index].key);
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

  Widget Postsui( String quantity,String itemname,String type,String key)
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    type,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  RaisedButton(
                    elevation: 20.0,
                    child:Text('Delete',style: TextStyle(
                      fontSize: 20,color: Colors.white
                    ),),
                    color: Colors.red,
                    onPressed: (){
                      showAlert(context, key,itemname);
                    },
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
