import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../widgets/productsgrid.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum FilterOptions{
  Favorties,
  All,
}

class ProductsOverviewScreen   extends StatefulWidget {



  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites=false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:Text('Myshop') ,
        actions:<Widget> [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                  if(selectedValue==FilterOptions.Favorties){
                _showOnlyFavorites=true;
                
              } else{
                _showOnlyFavorites=false;
            
              }
                
              });
            

            },
            icon: Icon(
              Icons.more_vert,

            ),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only favorties'),value:FilterOptions.Favorties),
              PopupMenuItem(child: Text('show all'),value:FilterOptions.All),
            ],

          ),
          Consumer<Cart>(builder:(_,cart,ch)=>Badge(
            child: ch,
             value: cart.itemCount.toString(),
             ),
             child:IconButton(
              icon:Icon(
                Icons.shopping_cart,
              ) ,
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              ) ,
             ) ,

        ],
        ),
        body: ProductsGrid(_showOnlyFavorites),
      
    );
  }
}

