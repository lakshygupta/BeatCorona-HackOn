import 'package:flutter/material.dart';
import 'package:flutternewsapp/homepage.dart';
import 'data.dart';
import 'newsfeeds.dart';
import 'Register.dart';
import 'homepage.dart';
import 'count.dart';
import 'world_cases.dart';
import 'live_updates.dart';
void main() {
  runApp(MaterialApp(
    home: Need(),
  ));
}

void notesOpen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your List'),
          backgroundColor: Colors.red[400],
        ),
      );
    },
  ));
}

class Need extends StatelessWidget {
  List<Data> data = [
    Data(text: 'Fruits', customor: 'Dhwaj Gupta', category: 'fruits'),
    Data(text: 'MILK', customor: 'Rahul', category: 'Home'),
    Data(text: 'Water Bottles', customor: 'LakshyGupta', category: 'Home'),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beat Corona'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.speaker_notes),
            onPressed: () {
              notesOpen(context);
            },
          )
        ],
      ),
      body: Column(
          children: data.map((list) {
        return Cardneed(list);
      }).toList()),
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
              leading: Icon(Icons.computer),
              title: Text(
                'Register',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new CustomForm()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.alarm),
              title: Text(
                'Reminders',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text(
                'Get News',
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
              leading: Icon(Icons.event_note),
              title: Text(
                'Login Again',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Splash()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text(
                'Nearby Shops',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
			ListTile(
                leading:Icon(Icons.location_city) ,
                title: Text('India Cases',
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
                          new UserList()));
                },
              ),
            ListTile(
              leading:Icon(Icons.gps_fixed) ,
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
              leading:Icon(Icons.live_tv) ,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var id = 1;
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new NewsFeedPage(id)));
        },
        child: Icon(Icons.event),
      ),
    );
  }
}
