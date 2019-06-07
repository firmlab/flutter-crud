import 'package:flutter/material.dart';

import '../sections/list_view_product.dart';

class ProductListPage extends StatelessWidget {
  final List<Map> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // RaisedButton(
          //   child: Text('ADD PRODUCT'),
          //   onPressed: () => addProduct({
          //         'title': 'New new product',
          //         'description': 'this is just description',
          //         'image': 'assets/bread.jpg'
          //       }),
          // ),
          Expanded(
            child: ListViewProduct(products, updateProduct, deleteProduct),
          ),
        ],
      ),
    );
  }
}
