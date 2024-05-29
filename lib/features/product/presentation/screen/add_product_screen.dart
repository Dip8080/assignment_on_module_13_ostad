import 'dart:convert';

import 'package:assignment_on_module_13_ostad/features/Home/Presentaion/screen/Home.dart';
import 'package:assignment_on_module_13_ostad/features/product/data/add_product_new.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> addNewProduct() async {
      Map<String, dynamic> produtData = {
        'ProductName': _nameController.text,
        'ProductCode': _nameController.text,
        'UnitPrice': _unitPriceController.text,
        'Qty': _quantityController.text,
        'TotalPrice': _totalPriceController.text,
        'Img': _imageController.text.trim()
      };
      final response = await http.post(
          Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(produtData));
      if (response.statusCode == 200) {
        print('data insertion successfully done, data: ${response.body}');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else {
        throw Exception('failed to insert data');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
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
                  autovalidateMode: AutovalidateMode.always,
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
                  controller: _productCodeController,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                      hintText: 'Product code', labelText: 'Product code'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product Code';
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
                      addNewProduct();
                    }
                  },
                  child: const Text('Add'),
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
