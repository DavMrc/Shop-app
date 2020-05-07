import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/PProducts.dart';


class SNewProduct extends StatefulWidget {
  static const routeName = "/new-products";

  @override
  _SNewProductState createState() => _SNewProductState();
}

class _SNewProductState extends State<SNewProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _imageURLFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _tempProduct = {
    'id': null,
    'title': "",
    'description': "",
    'price': 0.0,
    'imageUrl': ""
  };

  @override
  void initState() {
    this._imageURLFocusNode.addListener(this._updateImageURL);
    
    super.initState();
  }

  @override
  void dispose() {
    this._priceFocusNode.dispose();
    this._descriptionFocusNode.dispose();
    this._imageURLController.dispose();
    this._imageURLFocusNode.dispose();
    this._imageURLFocusNode.removeListener(this._updateImageURL);
    
    super.dispose();
  }

  void _updateImageURL(){
    if(! this._imageURLFocusNode.hasFocus){
      setState(() {});  // rebuilds the UI displaying the image
    }
  }

  String _validateInput(String value, String _inputType){
    if(_inputType == "title" ||
      _inputType == "description" ||
      _inputType == "imageUrl"
    ){
      if (value == "") return "Check your input!";
      else return null;
    }else if (_inputType == "price"){
      if(double.tryParse(value) == null) return "Provide a valid number!";
      else if (value == '' || double.parse(value) <= 0) return "Check your input!";
      else return null;
    }
  }

  void _saveForm(BuildContext ctx){
    bool isValid = this._formKey.currentState.validate();
    if(! isValid) return;

    this._formKey.currentState.save();  // triggers every input.onSaved method
    var productProvider = Provider.of<PProducts>(ctx, listen: false);

    Product product = Product(
      id: "p${productProvider.all.length}",
      description: this._tempProduct['description'],
      imageUrl: this._tempProduct['imageUrl'],
      price: this._tempProduct['price'],
      title: this._tempProduct['title'],
    );

    productProvider.addProduct(product);
    productProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => this._saveForm(context),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: this._formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Title",),
                  textInputAction: TextInputAction.next,  // shows "->" on softkey
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(this._priceFocusNode),
                  onSaved: (value) => this._tempProduct['title'] = value,
                  validator: (value) => this._validateInput(value, 'title'),
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: "Price",),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: this._priceFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(this._descriptionFocusNode),
                  onSaved: (value) => this._tempProduct['price'] = double.parse(value),
                  validator: (value) => this._validateInput(value, 'price'),
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: "Description",),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: this._descriptionFocusNode,
                  onSaved: (value) => this._tempProduct['description'] = value,
                  validator: (value) => this._validateInput(value, 'description'),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          )
                        ),

                        child: this._imageURLController.text.isEmpty
                        ? Center(child: Text("Enter a URL"))
                        : FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(this._imageURLController.text),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Image URL",),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: this._imageURLController,
                          focusNode: this._imageURLFocusNode,
                          onFieldSubmitted: (_) => this._saveForm(context),
                          onSaved: (value) => this._tempProduct['imageUrl'] = value,
                          validator: (value) => this._validateInput(value, 'imageUrl'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}