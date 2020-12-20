import 'dart:async';
import 'dart:ui';

import 'package:DesiMartProto/classes/Item.dart';
import 'package:flutter/material.dart';

class AdvertisementWidget extends StatefulWidget {
  List<Item> items;
  AdvertisementWidget(this.items);
  @override
  _AdvertisementWidgetState createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  int index;
  Timer _timer;

  void initState() {
    super.initState();
    index = 0;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        index = (index + 1) % widget.items.length;
      });
    });
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black38.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          Image.network(
            widget.items[index].photoURL,
            gaplessPlayback: true,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              widget.items[index].shopName + '\n' + widget.items[index].name,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
