import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/api/food_api.dart';
import 'package:flutternewsapp/buy/mylist.dart';
import 'package:flutternewsapp/login.dart';
import 'package:flutternewsapp/reminders.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'api/auth_notifier.dart';
import 'model/data.dart';
import 'Register.dart';
import 'Drawer/newsfeeds.dart';
import 'Drawer/world_cases.dart';
import 'Drawer/live_updates.dart';
import 'package:flutternewsapp/Drawer/count.dart';
import 'Drawer/precautions.dart';
import 'Drawer/bibliography.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutternewsapp/buy/tabs.dart';

void notesOpen(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    final DBRef = FirebaseDatabase.instance.reference().child('Users');
    DBRef.child(user.uid).set(
        {
          'id': user.uid,
          'email':user.email,
          'phone':'',
          'type' :'c'
        }
    );
  void writeData() {
    DBRef.child("Requirements").set(
        {
          'id': 'ID1',
          'data': 'This is sample data'
        }
    );
  }
    void readData() {
      DBRef.once().then(
              (DataSnapshot snapshot) {
            print(snapshot.value);
          }

      );
    }
  void updateData() {
          DBRef.update({
            'data':'updated'
          });
  }
  void deleteData() {
    DBRef.remove();
  }
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Your List'),
            backgroundColor: Colors.red[400],
          ),
          body: Row(
            children: <Widget>[
              RaisedButton(
                child: Text('Write here'),
                onPressed: () {
                  writeData();
                },
              ),
              RaisedButton(
                child: Text('read data'),
                onPressed: () {
                  readData();
                },

              ),
                RaisedButton(
                child: Text('Update'),
              onPressed: () {
                  updateData();
                },
                ),
              RaisedButton(
                child: Text('Delete'),
              onPressed: () {
              deleteData();
              },
              )
            ],
          ),
        );
      },
    ));
  }


class Need extends StatefulWidget {
  @override
  _NeedState createState() => _NeedState();
}

class _NeedState extends State<Need> {
  List<Data> data = [
    Data(text: 'Fruits', customor: 'Dhwaj Gupta', category: 'fruits'),
    Data(text: 'MILK', customor: 'Rahul Kushwaha', category: 'Home'),
    Data(text: 'Water Bottles', customor: 'Lakshy Gupta', category: 'Home'),
  ];
  void showAlert(context)
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
        signout(authNotifier);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Do you want to Log out?"),
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

  Widget getIcon(list) {
    print(list.category);
    if (list.category == 'Home') {
      return Icon(Icons.local_grocery_store);
    } else if (list.category == 'fruits') {
      return Icon(Icons.free_breakfast);
    } else {
      return Icon(Icons.shopping_basket);
    }
  }

  Widget Cardneed(list) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new ListTile(
              title: new Text(
                list.text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              leading: getIcon(list),
            ),
            SizedBox(height: 6.0),
            new Divider(
              color: Colors.blue,
              indent: 16.0,
            ),
            Text(list.customor,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                )),
          ],
        ),
      ),
    );
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress = " ";
  final DBRef = FirebaseDatabase.instance.reference().child('Users');

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    _getCurrentLocation();

    DBRef.child(authNotifier.user.uid).update(
        {
          'location':_currentAddress,
        });
    print("Building Homepage");
    return Scaffold(
      appBar: AppBar(
        title: Text(authNotifier.user != null ? 'Welcome ' + authNotifier.user.displayName + ' '   : "Homepage", style: TextStyle(fontSize: 20.0),),
        backgroundColor: Colors.blue,
        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.speaker_notes),
//            onPressed: () {
//              notesOpen(context);
//          return signout(authNotifier);
//            },
//          ),
//          FlatButton(
////            color:Colors.green[500],
//            onPressed: () {
//              return signout(authNotifier);
//            },
//            child: Text(
//              "Log Out",
//              style: TextStyle(
//                fontSize: 15,
//                color: Colors.yellow,
//              ),
//            )
//          )
        IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
               //return signout(authNotifier);
                showAlert(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[

                  Text(
                    "Covid19 Symptoms",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        SymptomCard(
                          image: "assets/cough.png",
                          title: "Cough",
                        ),
                        SymptomCard(
                          image: "assets/fever.png",
                          title: "Fever",
                        ),

                        SymptomCard(
                          image: "assets/shortness-of-breath.png",
                          title: "Tiredness",
//                          isActive: true,
                        ),
                        SymptomCard(
                          image: "assets/difficulty-breathing.png",
                          title: "Difficulty Breathing",
//                          isActive: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text("Preventions", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                    "Avoid close contact with people who are sick and Stay Home as much as possible.",
                    image: "assets/protect-quarantine.png",
                    title: "Avoid close contact",
                  ),
                  PreventCard(
                    text:
                    "Wash your hands often with soap and water for at least 20 seconds especially after you have been in a public place.",
                    image: "assets/protect-wash-hands.png",
                    title: "Wash your hands",
                  ),
                  PreventCard(
                    text:
                    "Everyone should wear a cloth face cover when they have to go out in public, for example to the grocery store.",
                    image: "assets/cloth-face-cover.png",
                    title: "Wear Mask",
                  ),
                  PreventCard(
                    text:
                    "Remember to cover your mouth and nose when you cough or sneeze or use the inside of your elbow.",
                    image: "assets/COVIDweb_06_coverCough.png",
                    title: "Cover your mouth",
                  ),
                  PreventCard(
                    text:
                    "Clean AND disinfect frequently touched surfaces daily. Use detergent or soap and water prior to disinfection.",
                    image: "assets/COVIDweb_09_clean.png",
                    title: "Clean and disinfect",
                  ),
                  SizedBox(height: 60),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Beat Corona',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/beat.png"),
                    fit: BoxFit.cover
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.computer,
              color: Colors.red,),
              title: Text(
                'Register/Login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.event_note,
                color: Colors.blue,),
              title: Text(
                'My Buying list',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Mylist()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.event_note,
              color: Colors.blue,),
              title: Text(
                'Latest News',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {

                var id = 1;
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new NewsFeedPage(id)));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading:Icon(Icons.location_city,
                color: Colors.orange,) ,
              title: Text('India Cases',
                style: TextStyle(
                  fontSize: 20,
                ),),
              onTap: () {
                  Navigator.push(
                context,
                new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new UserList()));
                },

                // Update the state of the app.
                // ...
            ),
            ListTile(
              leading:Icon(Icons.gps_fixed,
                color: Colors.blue[400],) ,
              title: Text('World Cases',
                style: TextStyle(
                  fontSize: 20,
                ),),
              onTap: () {
                // Update the state of the app.
                // ...

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new UserList1()));
              },
            ),
            ListTile(
              leading:Icon(Icons.live_tv,
                color: Colors.yellow[600],) ,
              title: Text('Live Updates',
                style: TextStyle(
                  fontSize: 20,
                ),),
              onTap: () {
                // Update the state of the app.
                // ...

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                      title: "Live Updates",
                      selectedUrl: "https://linkpe.in/",
                    )));
              },
            ),
            ListTile(
              leading:Icon(Icons.local_hospital,
                color: Colors.red,) ,
              title: Text('Precautions',
                style: TextStyle(
                  fontSize: 20,
                ),),
              onTap: () {
                // Update the state of the app.
                // ...

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new InfoScreen()));
              },
            ),
            ListTile(
              leading:Icon(Icons.developer_mode,
                color: Colors.green,) ,
              title: Text('About',
                style: TextStyle(
                  fontSize: 20,
                ),),
              onTap: () {
                // Update the state of the app.
                // ...
                _getCurrentLocation();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new Sources()));
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new,
                color: Colors.red,),
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {

                showAlert(context);
                // Update the state of the app.
                // ...
              },
            ),
            new Divider(color: Colors.blueGrey,),
            ListTile(
              title: Text("Rahul Kushwaha | Dhwaj Gupta | Lakshy Gupta" ,style: TextStyle(fontSize: 11.0, color: Colors.grey,), ),
            ),
            ListTile(
              title: Text('Your address: '+_currentAddress ,style: TextStyle(fontSize: 11.0, color: Colors.grey,), ),
            )
          ],
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

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

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

      setState(() {
        _currentAddress =
        "${place.thoroughfare},\n ${place.subAdministrativeArea}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 180,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 15,

                  ),
                ],
              ),
            ),
            Image.asset(image, width: 140.0,height: 300.0,),
//            Image.asset(image, alignment: Alignment.center,),

            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 145,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    new Divider(),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
//                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 150.0,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
//            color: kActiveShadowColor,
          )
              : BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 3,
//            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image,),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}