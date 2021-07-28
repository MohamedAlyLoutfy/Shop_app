import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/productsgrid.dart';
class ProductsOverviewScreen   extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Myshop') ,
        ),
        body: ProductsGrid(),
      
    );
  }
}

