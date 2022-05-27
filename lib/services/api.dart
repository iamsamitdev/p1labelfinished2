import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:p1label/models/ProductModel.dart';

class CallAPI {

  // สร้าง method read json products
  Future<List> readProduct(barcode) async {
    final resonse = await rootBundle.loadString('assets/data/products.json');
    final data = await json.decode(resonse);
    return data;
  }

  // อ่านข้อมูลสินค้า
  Future<List<ProductModel>> getAllProduct() async {
    String responseBody = await rootBundle.loadString('assets/data/products.json');
    var list = await json.decode(responseBody).cast<Map<String, dynamic>>();
    return await list.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
  }

}