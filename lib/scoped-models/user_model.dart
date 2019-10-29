import '../models/user.dart';
import 'connected_products_model.dart';

mixin UserModel on ConnectedProductsModel {
  MUser _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = MUser(id: 'ASD009123', email: email, password: password);
  }

}