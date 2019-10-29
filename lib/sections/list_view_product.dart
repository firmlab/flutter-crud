import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../components/products.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ListViewProduct extends StatefulWidget {

  final MainModel mainModel;
  
  ListViewProduct(this.mainModel);
  
  @override
  State<StatefulWidget> createState() {
    return _ListViewProductState();
  }
}

class _ListViewProductState extends State<ListViewProduct> {

  @override
  initState() {
    widget.mainModel.fetchProduct();
    super.initState();
  }
  
  Widget _buildListViewProduct(context, model, products) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(products[index].title),
            onDismissed: (DismissDirection direction) {
              model.selectProduct(index);
              model.deleteProduct();
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Product Deleted!")));
            },
            background: Container(color: Colors.red),
            child: GestureDetector(
              child: InkWell(
                child: Products(products[index], index),
                onTap: () => print(index.toString())
                 //developer.log(index.toString(), name: 'Ontap_Detail')
                    // Navigator.pushNamed(context, '/product/' + index.toString())
                    //     .then((value) {
                    //   if (value) {
                    //     model.selectProduct(index);
                    //     model.deleteProduct();
                    //   }
                    // }),
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        List<MProduct> products = model.products;
        Widget content;

        if (products.length > 0 && !model.loadingState) {
          content = _buildListViewProduct(context, model, products);
        } else if (model.loadingState) {
          content = Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          );
        } else {
          content = Center(
            child: Text('No Products Found!'),
          );
        }

        return content;
      },
    );
  }
}
