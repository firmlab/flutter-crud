import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductDetail extends StatelessWidget {
  final int productIndex;

  ProductDetail(this.productIndex);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        MProduct product = model.products[productIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('Product Detail'),
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(Icons.favorite),
            //     onPressed: () {},
            //   )
            // ],
          ),
          body: ListView(
            children: <Widget>[
              Image.asset(product.image),
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
                            product.title,
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
                            '\$' + product.price.toString(),
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
                        product.description,
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
                                          style: TextStyle(
                                              color: Colors.blueAccent),
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
        );
      }),
    );
  }
}
