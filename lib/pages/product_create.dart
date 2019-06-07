import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map product;
  final int productIndex;

  ProductCreatePage({this.addProduct, this.updateProduct, this.product, this.productIndex});

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

  void submitForm(context) {
    String msg = widget.product == null
        ? 'Yay! Product Saved!'
        : 'Yay! Product Updated!';

    final snackBar = SnackBar(
      content: Text(msg),
    );

    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    Map formData = {
      'title': productTitle,
      'description': productDescription,
      'price': productPrice,
      'image': 'assets/bread.jpg'
    };

    if (widget.product == null) {
      widget.addProduct(formData);
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      widget.updateProduct(widget.productIndex, formData);
      _scaffoldKey.currentState.showSnackBar(snackBar); 
    }

    if (widget.product == null) {
      formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent = GestureDetector(
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
                initialValue:
                    widget.product == null ? '' : widget.product['title'],
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
                initialValue: widget.product == null
                    ? ''
                    : widget.product['price'].toString(),
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
                initialValue:
                    widget.product == null ? '' : widget.product['description'],
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
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('SAVE'),
                  onPressed: () {
                    submitForm(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            key: _scaffoldKey,
            body: Builder(builder: (BuildContext context) {
              return pageContent;
            }),
          );
  }
}
