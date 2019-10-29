import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'product_list.dart';
import 'product_create.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(APP_NAME),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
                text: 'List Product',
              ),
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Login'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductListPage(),
            ProductCreatePage(),
          ],
        ),
      ),
    );
  }
}
