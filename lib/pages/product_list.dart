import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../sections/list_view_product.dart';
import '../scoped-models/main.dart';

class ProductListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
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
              child: RefreshIndicator(
                child: ListViewProduct(model),
                color: Colors.blueAccent,
                onRefresh: () {
                  return model.fetchProduct();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
