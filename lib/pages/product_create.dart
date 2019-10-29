import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String productTitle;
  double productPrice;
  String productDescription;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void submitForm(context, Function addProduct, Function updateProduct,
      selectedProductIndex) {
    String msg = selectedProductIndex == null
        ? 'Yay! Product Saved!'
        : 'Yay! Product Updated!';

    final snackBar = SnackBar(
      content: Text(msg),
    );

    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    MProduct formData = MProduct(
        title: productTitle,
        description: productDescription,
        price: productPrice,
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9psvCSc5aL__sCoqeusLjhlfZ73UyqlJU5TPy-A5f1xaORzxiIA');

    if (selectedProductIndex == null) {
      addProduct(formData).then((_) {
        Scaffold.of(context).showSnackBar(snackBar);
        formKey.currentState.reset();
      });
    } else {
      updateProduct(formData);
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget _buildPageContent(context, model, selectedProduct) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                initialValue: model.selectedProductIndex == null
                    ? ''
                    : selectedProduct.title,
                decoration: InputDecoration(labelText: 'Product Title'),
                onSaved: (value) {
                  // setState(() {
                  productTitle = value;
                  // });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Product title field is required!';
                  }
                },
              ),
              TextFormField(
                maxLines: 1,
                initialValue: model.selectedProductIndex == null
                    ? ''
                    : selectedProduct.price.toString(),
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  // setState(() {
                  productPrice = double.parse(value);
                  // });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Product price field is required!';
                  }
                },
              ),
              TextFormField(
                maxLines: 4,
                initialValue: model.selectedProductIndex == null
                    ? ''
                    : selectedProduct.description,
                decoration: InputDecoration(labelText: 'Product Description'),
                onSaved: (value) {
                  // setState(() {
                  productDescription = value;
                  // });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Product description field is required!';
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: ScopedModelDescendant<MainModel>(
                  builder:
                      (BuildContext context, Widget child, MainModel modelM) {
                    return modelM.loadingState
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blueAccent),
                            ),
                          )
                        : RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text('SAVE'),
                            onPressed: () {
                              submitForm(
                                  context,
                                  model.addProduct,
                                  model.updateProduct,
                                  model.selectedProductIndex);
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        rebuildOnChange: false,
        builder: (BuildContext context, Widget child, MainModel model) {
          final MProduct selectedProduct = model.selectedProductIndex == null
              ? MProduct(
                  title: null, description: null, image: null, price: null)
              : model.selectedProduct;

          return model.selectedProductIndex == null
              ? _buildPageContent(context, model, selectedProduct)
              : WillPopScope(
                  onWillPop: () {
                    Navigator.pop(context, true);
                    //future params harus false, biar g tabrakan dengan navigator.pop, jadi yang dipassing datanya adalah dari navigator
                    return Future.value(false);
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Edit Product'),
                    ),
                    key: _scaffoldKey,
                    body: _buildPageContent(context, model, selectedProduct),
                  ),
                );
        });
  }
}
