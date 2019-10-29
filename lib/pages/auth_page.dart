import 'package:flutter/material.dart';
import '../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email;
  String password;

  submitForm(context, Function login) {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    login(email, password);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 400.0 : deviceWidth * 0.95;

    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Login'),
        // ),
        body: Stack(
      children: <Widget>[
        Center(
          child: new Image.asset(
            'assets/blue_.png',
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30.0),
            child: Card(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'FLUTTER SECOND',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        onSaved: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email field is required';
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password field is required';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: ScopedModelDescendant<MainModel>(builder:
                            (BuildContext context, Widget child,
                                MainModel model) {
                            return RaisedButton(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                submitForm(context, model.login);
                              },
                            );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    )
        // Center(
        //   child: RaisedButton(
        //     child: Text('LOGIN'),
        //     onPressed: () {
        //       Navigator.pushReplacementNamed(context, '/home');
        //     },
        //   ),
        // ),
        );
  }
}
