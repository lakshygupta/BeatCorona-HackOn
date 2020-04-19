import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/api/auth_notifier.dart';
import 'package:flutternewsapp/api/food_api.dart';
import 'package:flutternewsapp/buy/tabs.dart';
import 'package:flutternewsapp/model/lists.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutternewsapp/model/shops.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position _currentPosition;
String _currentAddress = " ";
_getCurrentLocation() {
  geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    _currentPosition = position;
    _getAddressFromLatLng();
  }).catchError((e) {
    print(e);
  });
}

_getAddressFromLatLng() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

    Placemark place = p[0];

    _currentAddress =
    "${place.thoroughfare},\n ${place.subAdministrativeArea}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  } catch (e) {
    print(e);
  }
}
class Shoplist extends StatefulWidget {
  @override
  _ShoplistState createState() => _ShoplistState();
}

class _ShoplistState extends State<Shoplist> {
  List<Shopmy> shoplist = [];
  bool isLoading  = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    print('current address'+_currentAddress);
    print(_currentAddress);
    List<String> splittedaddress = _currentAddress.split(',');
    String modifiedadd =  splittedaddress[2].toString() +splittedaddress[3].toString() +splittedaddress[4].toString()+splittedaddress[5].toString();
    print(modifiedadd);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    final DBref = FirebaseDatabase.instance.reference().child('Users');
    DBref.once().then((DataSnapshot snap) {

      if(snap.value!=null) {
        var KEYS = snap.value.keys;
        var DATA = snap.value;
        shoplist.clear();

        for (var individualKey in KEYS) {
          if(DATA[individualKey]['type']=='Seller') {

            List<String> splitted = DATA[individualKey]['location'].split(',');
            String mod =  splitted[2].toString() +splitted[3].toString() +splitted[4].toString()+splitted[5].toString();

            if(mod==modifiedadd) {
              Shopmy my = new Shopmy
                (
                shopname: DATA[individualKey]['shopname'],
                location: DATA[individualKey]['location'],
                key: individualKey,
              );
              shoplist.add(my);
            }
          }
        }

        setState(() {
          print('buyinglist=$shoplist.length');
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
        title: Text('Nearby Shops'),
      ),
      body: new Container(
        child: isLoading ? Center( child: CircularProgressIndicator(),): shoplist.length == 0? Center(
    child: new Text("All the added items will be shown here",style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20
    ),)) : new ListView.builder(
          itemCount: shoplist.length,
          itemBuilder: (_,index)
          {
              print('key==='+shoplist[index].key);
              return Postsui(shoplist[index].shopname, shoplist[index].location,shoplist[index].key);
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

  Widget Postsui( String shopname,String location,String key)
  {
    return new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child:
        new Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    shopname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),

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
                    location,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
