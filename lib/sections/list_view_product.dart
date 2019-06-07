import 'package:flutter/material.dart';

import '../components/products.dart';

class ListViewProduct extends StatelessWidget {
  final List<Map> products;
  final Function updateProduct;
  final Function deleteProduct;

  ListViewProduct(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(products[index]['title']),
            onDismissed: (DismissDirection direction) {
              deleteProduct(index);
              Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Product Deleted!")));
            },
            background: Container(color: Colors.red),
            child: GestureDetector(
              child: InkWell(
                child: Products(products[index], updateProduct, index),
                onTap: () =>
                    Navigator.pushNamed(context, '/product/' + index.toString())
                        .then((value) {
                      if (value) {
                        deleteProduct(index);
                      }
                    }),
              ),
            ),
          );
          // return Container(
          //   height: 50,
          //   color: Colors.amber[colorCodes[index]],
          //   child: Center(child: Text('Entry ${entries[index]}')),
          // );
        });
  }
}
