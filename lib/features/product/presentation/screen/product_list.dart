import 'dart:js';

import 'package:assignment_on_module_13_ostad/features/Home/Presentaion/screen/Home.dart';
import 'package:assignment_on_module_13_ostad/features/product/data/get_product.dart';
import 'package:assignment_on_module_13_ostad/features/product/model/product.dart';
import 'package:assignment_on_module_13_ostad/features/product/model/update_product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Product>> data = GetProductData();

    void deleteProduct(String id) async {
      var response = await http.delete(
        Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/${id}'),
        headers: {"Content-Type": "application/json"},
      );
      print('this is print in widget - ${response.body}');
      if (response.statusCode == 200) {
        print('Product data removed successfully ');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else {
        throw Exception('Failed to remove products');
      }
    }

    print('this is data in widget - ');
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            ));
          } else if (snapshot.hasData) {
            final productData = snapshot.data!;
            return Padding(
              padding: EdgeInsets.only(top: 0, left: 4.w, right: 10),
              child: ListView.builder(
                  itemCount: productData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return ImageDetails(id: productData[index].id!, title: productData[index].title!, image: productData[index].url!  ,);
                        // })) ;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black)
                            ),
                        width: 100.w,
                        height: 12.h,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(productData[index].img!),
                              )),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                                child: Text(productData[index].productName!,
                                    style: TextStyle(
                                        fontSize: 5.w,
                                        fontWeight: FontWeight.w700))),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateProduct(
                                      productId: productData[index].id!,
                                      productName:
                                          productData[index].productName!,
                                    );
                                  }));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deleteProduct(productData[index].id!);
                                },
                                icon: Icon(Icons.remove))
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Text('Sorry, No data available !');
          }
        });
  }
}
