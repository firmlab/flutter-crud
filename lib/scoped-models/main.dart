import 'package:scoped_model/scoped_model.dart';

import './products_model.dart';
import './user_model.dart';
import './connected_products_model.dart';

class MainModel extends Model with ConnectedProductsModel, ProductsModel, UserModel{

}