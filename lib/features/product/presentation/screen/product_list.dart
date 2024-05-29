import 'package:assignment_on_module_13_ostad/features/Home/Presentaion/screen/Home.dart';
import 'package:assignment_on_module_13_ostad/features/product/data/get_product.dart';
import 'package:assignment_on_module_13_ostad/features/product/model/product.dart';
import 'package:assignment_on_module_13_ostad/features/product/model/update_product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  
  @override
  initState(){
    super.initState();
    GetProductData();
  }
  
  @override
  Widget build(BuildContext context) {
    Future<List<Product>> data = GetProductData();
  
  
    void deleteProduct(String id) async {
      var response = await http.get(
        Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/${id}'),
        // headers: {"Content-Type": "application/json"},
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
            final productData = snapshot?.data ?? []; 
            return Padding(
              padding: EdgeInsets.only(top: 0, left: 4.w, right: 10),
              child: ListView.builder(
                  itemCount: productData?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return ImageDetails(id: productData[index].idproductName, title: productData[index].titleproductName, image: productData[index].urlproductName  ,);
                        // })) ;
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
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
                                image: NetworkImage(productData[index].img ?? 'https://i.ebayimg.com/images/g/s2cAAAzyLv1SvhXh/s-l600.jpg'),
                              )),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                            child: 
                                Text(
                                  productData[index].productName ?? 'demo name',
                                  style: TextStyle(
                                      fontSize: 5.w,
                                      fontWeight: FontWeight.w700),
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     Text(productData[index].unitPriceproductName),
                                //     SizedBox(width: 2.w,),
                                //     Text(productData[index].qtyproductName),
                                //   ],
                                // )
                          
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateProduct(
                                      productId: productData[index].id ?? '0',
                                      productName:
                                          productData[index].productName ?? 'demo name',
                                    );
                                  }));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deleteProduct(productData[index].id ?? 0.toString());
                                },
                                icon: Icon(Icons.delete_outline_sharp) , color: Colors.red,)
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Text('Sorry, No data available productName');
          }
        });
  }
}
