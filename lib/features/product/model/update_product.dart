
import 'dart:convert';

import 'package:assignment_on_module_13_ostad/features/Home/Presentaion/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProduct extends StatefulWidget {
  const UpdateProduct(
      {super.key, required this.productName, required this.productId});

  final String productName;
  final String productId;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void HandleUpdateProduct() async {
      Map produtData = {
        'ProductName': _nameController.text,
        'UnitPrice': _unitPriceController.text,
        'Qty': _quantityController.text,
        'TotalPrice': _totalPriceController.text,
        'Img' : _imageController.text
      };
      print(produtData);
      var response = await http.post(
          Uri.parse(
              'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.productId}'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(produtData));
      print('this is print in widget - ${response.body}');
      if (response.statusCode == 200) {
        print('Product data updated successfully ');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else {
        throw Exception('Failed to update products');
      }
    }

    ;

    return Scaffold(
      appBar: AppBar(
        title: Text('update product - ${widget.productName}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      hintText: 'Name', labelText: 'Name'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _unitPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Unit Price', labelText: 'Unit Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your unit price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Quantity', labelText: 'Quantity'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _totalPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Total Price', labelText: 'Total Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your total price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                      hintText: 'Image', labelText: 'Image'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your image';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      HandleUpdateProduct();
                    }
                  },
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _totalPriceController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
