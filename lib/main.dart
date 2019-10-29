import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped-models/main.dart';
import 'pages/auth_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
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
          '/home': (BuildContext contex) => HomePage()
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);

            return MaterialPageRoute(
              builder: (context) => ProductDetail(index),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => HomePage());
        },
      ),
    );
  }
}
