import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<void> addNewProduct(Map<String , dynamic> productData) async {
    
      final response = await http.post(
          Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(productData));
      if (response.statusCode == 200) {
        print('data insertion successfully done, data: ${response.body}');
        
      } else {
        throw Exception('failed to insert data');
      }
    }