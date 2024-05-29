import 'package:assignment_on_module_13_ostad/features/product/presentation/screen/add_product_screen.dart';
import 'package:assignment_on_module_13_ostad/features/product/presentation/screen/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar( 
        backgroundColor: Colors.orange,
        title: Text('Product List' , style: TextStyle(fontSize: 6.w
        ,color: Colors.white
      ),),
      ),
      body: ProductList(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) {
          return AddProductScreen();
        }));
      
      },
      child:  Icon(Icons.add , color: Colors.black,),
      ),
    );
  }
}