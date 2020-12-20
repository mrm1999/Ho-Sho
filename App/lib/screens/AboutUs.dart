import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Widget _returnCard(String name, String email, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).accentColor,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Container(
              height: 300.0,
              color: Theme.of(context).accentColor,
              child: Center(
                child: Image.network(url, height: 290.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Text(
                email,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'About Us',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView(
          children: [
            _returnCard('Mohit Raj Munot', 'mohitrajmunot1999@gmail.com',
                'https://scontent.fidr2-1.fna.fbcdn.net/v/t1.0-9/45377513_1865093373609027_9220253860533108736_o.jpg?_nc_cat=103&ccb=2&_nc_sid=174925&_nc_ohc=2t-OqULe1hUAX-yIYcq&_nc_ht=scontent.fidr2-1.fna&oh=41b28e381c31097171ba219f5fc9e212&oe=60040D9A'),
            _returnCard('Ayush Agrawal', 'aaaayush25@gmail.com',
                'https://scontent.fidr2-1.fna.fbcdn.net/v/t1.0-9/38758786_1783350651760783_5556457275972911104_o.jpg?_nc_cat=103&cb=846ca55b-ee17756f&ccb=2&_nc_sid=09cbfe&_nc_ohc=hpMEXm1FHY0AX-FzwfK&_nc_ht=scontent.fidr2-1.fna&oh=090376d474fa05fe62dd6866cf96def0&oe=60021F9A'),
            _returnCard('Harsh Chaurasia', 'harshchrs2312@gmail.com',
                'https://scontent.fidr2-1.fna.fbcdn.net/v/t1.0-9/49603626_1970631839699329_4940251252794589184_n.jpg?_nc_cat=103&ccb=2&_nc_sid=0debeb&_nc_ohc=saQaZpEQ_dQAX9LJbIS&_nc_ht=scontent.fidr2-1.fna&oh=cc8a6a03df29d98812a4feafad9eedfb&oe=6004D1AF'),
          ],
        ),
      ),
    );
  }
}
