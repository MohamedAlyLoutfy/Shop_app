import 'dart:convert';
import 'package:flutter/foundation.dart';
import './cart.dart' as ci;
import 'package:http/http.dart' as http;
class OrderItem{
  final String id;
  final double amount;
  final List<ci.CartItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });


}
class Orders with ChangeNotifier{
  List<OrderItem> _orders=[];
  List<OrderItem> get orders{
    return[..._orders];
  }
  Future <void> addOrder(List<ci.CartItem> cartProducts,double total)async{
   const url='https://flutter-update-43761-default-rtdb.firebaseio.com/orders.json';
    final timestamp=DateTime.now();
    final response=await http.post(Uri.parse(url),
    body: json.encode({
      'amount':total,
      'dateTime':timestamp.toIso8601String(),
      'products':cartProducts.map((cp) => {
        'id':cp.id,
        'title':cp.title,
        'quantity':cp.quantity,
        'price':cp.price,


      }).toList(),


    }),
    );
    _orders.insert(
      0,
       OrderItem(
         id:json.decode(response.body)['name'],
         amount: total,
         dateTime: timestamp,
         products: cartProducts,

         ),
         );
         notifyListeners();


  }
}