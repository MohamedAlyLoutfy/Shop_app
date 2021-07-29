import 'package:flutter/material.dart';
import '../providers/product.dart';
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
    //print(_editProduct.title);
    //print(_editProduct.price);
    //print(_editProduct.description);
    //print(_editProduct.imageUrl);
  

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