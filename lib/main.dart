import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_second/pages/auth_page.dart';

import 'utils/constants.dart';
import 'pages/home_page.dart';
import 'pages/product_detail.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  List<Map> _products = [
    {
      'title': 'Product A',
      'price': 12.0,
      'description': 'this is just description A',
      'image': 'assets/bread.jpg'
    },
    {
      'title': 'Product B',
      'price': 11.0,
      'description': 'this is just description B',
      'image': 'assets/bread2.jpg'
    },
    {
      'title': 'Product C',
      'price': 15.0,
      'description': 'this is just description C',
      'image': 'assets/bread.jpg'
    },
    {
      'title': 'Product D',
      'price': 17.0,
      'description': 'this is just description D',
      'image': 'assets/bread2.jpg'
    },
  ];

  void _addProduct(Map product) {
    setState(() {
      _products.add(product);
    });
  }

  void _updateProduct(int index, Map product) {
    setState(() {
      _products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent, size: 16.0),
      ),
      home: AuthPage(),
      routes: {
        // '/' : ini akah sama dengan home:
        '/login': (BuildContext context) => AuthPage(),
        '/home': (BuildContext contex) =>
            HomePage(_products, _addProduct, _updateProduct, _deleteProduct)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');

        if (pathElements[0] != '') {
          return null;
        }

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);

          return MaterialPageRoute(
            builder: (context) => ProductDetail(
                title: _products[index]['title'],
                image: _products[index]['image'],
                description: _products[index]['description'],
                price: _products[index]['price']),
          );
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (context) =>
                HomePage(_products, _addProduct, _updateProduct, _deleteProduct));
      },
    );
  }
}
