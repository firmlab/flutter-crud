import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pages/product_create.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class Products extends StatefulWidget {
  final MProduct product;
  final int index;

  Products(this.product, this.index);

  @override
  State<StatefulWidget> createState() {
    return ProductsState();
  }
}

class ProductsState extends State<Products> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Image.network(
                widget.product.image,
                width: 120.0,
              ),
              padding: EdgeInsets.only(right: 6.0),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    widget.product.title,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '\$' + widget.product.price.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Text(
                  widget.product.description,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
              return FlatButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  model.selectProduct(widget.index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ProductCreatePage();
                    })
                  ).then((value) {
                    if(value) {
                      model.resetSelectProduct();
                      model.fetchProduct();
                    }
                  });
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
