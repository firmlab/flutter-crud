import 'package:flutter/material.dart';

import '../pages/product_create.dart';

class Products extends StatelessWidget {
  final Map product;
  final Function updateProduct;
  final int index;

  Products(this.product, this.updateProduct, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Image.asset(
                product['image'],
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
                    product['title'],
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '\$' + product['price'].toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Text(
                  product['description'],
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              child: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProductCreatePage(
                      product: product,
                      updateProduct: updateProduct,
                      productIndex: index,
                    );
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
