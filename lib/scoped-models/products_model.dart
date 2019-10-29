import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../models/product.dart';
import 'connected_products_model.dart';
import '../utils/constants.dart';

mixin ProductsModel on ConnectedProductsModel {
  List<MProduct> _products = [];
  int _selectedProductIndex;
  bool _isLoading = false;

  List<MProduct> get products {
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  bool get loadingState {
    return _isLoading;
  }

  MProduct get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  Future<Null> addProduct(MProduct product) {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> productData = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9psvCSc5aL__sCoqeusLjhlfZ73UyqlJU5TPy-A5f1xaORzxiIA'
    };

    return http
        .post(API_PRODUCT, body: json.encode(productData))
        .then((http.Response response) {
      // final Map result = json.decode(response.body);
      // print('AAA');
      // print(result);
      // _products.add(product);
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Future> fetchProduct() async {
    _isLoading = true;
    notifyListeners();
    print('BEFORE GET');
    return await http.get(API_PRODUCT).then((http.Response response) {
      print('RESULT GET');

      final Map productListData = json.decode(response.body);
      List<MProduct> fetchedProductList = [];
      if(productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((productId, productData) {
        final MProduct product = MProduct(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price']
        );

        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> updateProduct(MProduct product) {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> productData = {
      'id': selectedProduct.id,
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9psvCSc5aL__sCoqeusLjhlfZ73UyqlJU5TPy-A5f1xaORzxiIA'
    };

    return http
        .put(BASE_URL_API + 'products/${selectedProduct.id}.json', body: json.encode(productData))
        .then((http.Response response) {
      // final Map result = json.decode(response.body);
      // print('AAA');
      // print(result);
      // _products.add(product);
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> deleteProduct() {
    _isLoading = true;
    notifyListeners();
    return http
        .delete(BASE_URL_API + 'products/${selectedProduct.id}.json')
        .then((http.Response response) {
          _isLoading = false;
          _selectedProductIndex = null;
          fetchProduct();
          notifyListeners();
    });
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }

  void resetSelectProduct() {
    _selectedProductIndex = null;
    notifyListeners();
  }
}
