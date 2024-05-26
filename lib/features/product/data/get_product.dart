import 'dart:convert';
import 'package:assignment_on_module_13_ostad/features/product/model/product.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> GetProductData() async {
  var response = await http.get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'), headers: {"Content-Type": "application/json"});
   if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final products = data['data'].map<Product>((json) => Product.fromJson(json)).toList();
    print('Fetched products: $products');
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}
