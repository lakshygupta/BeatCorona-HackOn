import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
typedef OnDelete();

class User {
  String itemName;
  String qty;

  User({this.itemName , this.qty });
}

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}
void _showDialog(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Data Saved"),
        content: new Text("Data saved on database"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
      void Savelist(String itemname,String quantity) async
{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user.uid);
  final DBRef = FirebaseDatabase.instance.reference().child('Users');
  DBRef.child(user.uid).child('mylist').update(
      {
        'itemname':itemname,
        'quantity':quantity,
      }
  );
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
   var quantity = 'null';
   var itemname = 'null';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(

          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Item Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(

                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.itemName,

//                  validator: (val) =>
//                  val.length > 43 ? null : 'Enter valid item',
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    hintText: 'Enter your item name',
                    icon: Icon(Icons.person),
                    isDense: true,
                    fillColor: Color(0xFF30C1FF),
                  ),
                  onChanged: (String val) {
                    widget.user.itemName = val;
                    itemname = val;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.user.qty,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    hintText: 'Enter Quantity',
                    icon: Icon(Icons.equalizer),
                    isDense: true,
                  ),
                  onChanged: (String val) {
                    widget.user.qty = val;
                    quantity = val;
                    },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: RaisedButton(
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Notify and Save',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        textBaseline: TextBaseline.alphabetic
                    ),),
                  onPressed: ()  {
                    Savelist(itemname, quantity);
                    _showDialog(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new TabBarDemo()));
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}


class MultiForm extends StatefulWidget {

  @override
  _MultiFormState createState() => _MultiFormState();

}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,

        title: Text('List'),
        actions: <Widget>[
          FlatButton(
            child: Text('See Your list'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(000),
//          gradient: LinearGradient(
//            colors: [
//              Color(0xFF30C1FF),
//              Color(0xFF2AA7DC),
//            ],
//            begin: Alignment.topCenter,
//            end: Alignment.bottomCenter,
//          ),
        ),
        child: users.length <= 0
            ? Center(
          child: EmptyState(
            title: 'To buy item',
            message: 'Add item by tapping add button below',
          ),
        )
            : ListView.builder(
          addAutomaticKeepAlives: true,
          itemCount: 1,
          itemBuilder: (_, i) => users[i],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
            (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {

      var _user = User();
      if(users.length<1) {
        users.add(UserForm(
          user: _user,
          onDelete: () => onDelete(_user),
        ));
      }
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if(users.isEmpty){
        Text("Fill the list");
      }
      else {
        if (allValid) {
          var data = users.map((it) => it.user).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) =>
                  Scaffold(
                    appBar: AppBar(
                      title: Text('List of Items'),
                    ),
                    body: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, i) =>
                          ListTile(
                            leading: CircleAvatar(
                              child: Text(data[i].itemName.substring(0, 1)),
                            ),
                            title: Text(data[i].itemName),
                            subtitle: Text(data[i].qty),
                          ),
                    ),
                  ),
            ),
          );
        }
      }
    }
    else{
      Navigator.push(context, MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => Scaffold(
          body: Center(child: Text("Fill List"),),
        )
      ));
    }
  }
}

class EmptyState extends StatelessWidget {
  final String title, message;
  EmptyState({this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 16,
      color: Theme.of(context).cardColor.withOpacity(.95),
      shadowColor: Theme.of(context).accentColor.withOpacity(.5),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Groceries',

                ),
                Tab(
                  text:'Medicines',
                ),
                Tab(
                  text: 'others',
                ),
              ],
            ),
            title: Text('Add items to buy'),
          ),
          body: TabBarView(
            children: [
              MultiForm(),
              MultiForm(),
              MultiForm(),
            ],
          ),
        ),
      ),
    );
  }
}