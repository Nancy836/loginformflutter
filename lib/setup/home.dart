import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final userid;
  const HomePage({Key key, this.userid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


// a class with  three list view itsm if the name of each grou memeber alphabetically  
// also displayes the user ud ... 
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Break out room 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Your Unique user id:"),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.userid,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Break out room Members:"),
            ListTile(
              leading: CircleAvatar(),
              title: Text("Ian Wanjohi"),
            ),
            ListTile(
              leading: CircleAvatar(),
              title: Text("Kelvin Wachira"),
            ),
            ListTile(
              leading: CircleAvatar(),
              title: Text("Nancy Umutoni"),
            )
          ],
        ),
      ),
    );
  }
}
