import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/product_item.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (ctx)=>Products(),
      ),
      ChangeNotifierProvider(
      create: (ctx)=>Cart(),),
      ChangeNotifierProvider(
      create: (ctx)=>Orders(),),

    ],
   
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes:{
          ProductDetailScreen.routeName:(ctx) => ProductDetailScreen(),
          CartScreen.routeName:(ctx) => CartScreen(),
    
    
        }
      ),
    );
  }
}

