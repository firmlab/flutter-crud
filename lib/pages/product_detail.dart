import 'dart:async';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final double price;

  ProductDetail({this.title, this.image, this.description, this.price});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Product Detail')),
        body: ListView(
          children: <Widget>[
            Image.asset(image),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Text(
                          title,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        child: Text(
                          '\$' + price.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 4.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5.0)),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Divider(
                      height: 1.0,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      description,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('DELETE'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('You sure delete product?'),
                                  content:
                                      Text('This action can\'t be undone!'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'CANCEL',
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    FlatButton(
                                        child: Text(
                                          'YES, DELETE!',
                                          style: TextStyle(
                                              color: Colors.black45),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context, true);
                                        }),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
