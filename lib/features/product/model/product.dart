class Product {
  final String? id;
  final String? productName;
  final String? productCode;
  final String? img;
  final String? unitPrice;
  final String? qty;
  final String? totalPrice;
final DateTime? createdDate;

  Product({
     this.id,
     this.productName,
     this.productCode,
     this.img,
     this.unitPrice,
     this.qty,
     this.totalPrice,
     this.createdDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productName: json['ProductName'],
      productCode: json['ProductCode'],
      img: json['Img'],
      unitPrice: json['UnitPrice'],
      qty: json['Qty'],
      totalPrice: json['TotalPrice'],
      createdDate: DateTime.parse(json['CreatedDate']),
    );
  }

  
  
}