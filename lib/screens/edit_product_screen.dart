import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';
 class EditProductScreen  extends StatefulWidget {
   static const routeName='/edit-product';
 

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode=FocusNode();
  final _descriptionFocusNode=FocusNode();
  final _imageUrlController=TextEditingController();
  final _imageUrlFocusNode=FocusNode();
  final _form=GlobalKey<FormState>();
  var _editProduct=Product(id: null,
   title: '',
    description: '',
     price: 0, 
     imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
  void _updateImageUrl(){
    
    //when lose focus on text field of imgurl show the img
    if(!_imageUrlFocusNode.hasFocus){
      //if not valid don't show anything
      if(
      (!_imageUrlController.text.startsWith('http')&&
      !_imageUrlController.text.startsWith('https'))||
      (!_imageUrlController.text.endsWith('.png')&&
     !_imageUrlController.text.endsWith('jpg')&&
     !_imageUrlController.text.endsWith('jpeg')
     )
      ){return;}
      setState(() {
        
      });
    }

  }
  void _saveForm(){
    final isValid=_form.currentState.validate();
    if(!isValid){
      return;
    }
    _form.currentState.save();
   Provider.of<Products>(context,listen: false).addProduct(_editProduct);
   Navigator.of(context).pop();
  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Edit Product') ,
        actions:<Widget> [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))


        ],
        ),
        body: Padding(
          padding:const EdgeInsets.all(16.0) ,
          child: Form(
            key: _form,
            child: ListView(children:<Widget> [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value){
                if(value.isEmpty){
                  return ('Please provide a value');
                }
                return null;
              },
              onSaved: (value){
                _editProduct=Product(
                id: null,
                title: value,
                description: _editProduct.description,
                price: _editProduct.price,
                imageUrl: _editProduct.imageUrl);

              },
        
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
               onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator:(value){
                if (value.isEmpty){
                  return 'please enter a price.';

                }
                if(double.tryParse(value)==null){
                  return 'please enter a valid number';
                }
                if(double.parse(value)<=0){
                  return 'please a number greater than zero';

                }
                return null;

              } ,
                onSaved: (value){
                _editProduct=Product(
                id: null,
                title: _editProduct.title,
                description: _editProduct.description,
                price: double.parse(value),
                imageUrl: _editProduct.imageUrl);

              },
        
            ),
             TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3, 
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              validator: (value){
                if(value.isEmpty){
                  return 'Please enter description';

                }
                if(value.length<10){
                  return 'Should be at least 10 characters long';
                }
                return null;
              },
                onSaved: (value){
                _editProduct=Product(
                id: null,
                title: _editProduct.title,
                description: value,
                price: _editProduct.price,
                imageUrl: _editProduct.imageUrl);

              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children:<Widget> [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(
                  top: 8,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey,
                  width: 1
                  ),
                  ),
                  child: _imageUrlController.text.isEmpty?
                  Text('Enter a URL')
                  :FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                              decoration: InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_){
                                _saveForm();
                              },
                validator: (value){
                  if(value.isEmpty){
                    return 'Please  enter an img URL';
                  }
                  if(!value.startsWith('http') && !value.startsWith('https')){
                    return 'Please enter a vaild URL';
                  }
                 if(!value.endsWith('.png')&&!value.endsWith('jpg')&&!value.endsWith('jpeg')){
                    return 'Please enter a valid img URL';
                 }

                  return null;
                },
                onSaved: (value){
                _editProduct=Product(
                id: null,
                title: _editProduct.title,
                description: _editProduct.description,
                price: _editProduct.price,
                imageUrl:value);

              },
                              ),
                ),
    
              



            ],
            )

        
        
        
          ],),),
        ),
      
    );
  }
}