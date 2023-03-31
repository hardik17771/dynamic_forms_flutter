import 'package:flutter/material.dart';
void main()=> runApp(ProductForm());
class Product {
  String name;
  double price;
  int quantity;

  Product({required this.name, required this.price, required this.quantity});
}

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  List<Product> _products = [Product(name: "", price: 0, quantity: 0)];
  double _totalAmount = 0;

  void _updateTotalAmount() {
    double total = 0;
    _products.forEach((product) {
      total += product.price * product.quantity;
    });
    setState(() {
      _totalAmount = total;
    });
  }

  void _addProduct() {
    setState(() {
      _products.add(Product(name: "", price: 0, quantity: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text('Product Form'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product ${index + 1}'),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Product Name',
                            ),
                            initialValue: _products[index].name,
                            onChanged: (value) {
                              setState(() {
                                _products[index].name = value;
                              });
                            },
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Price',
                            ),
                            initialValue: _products[index].price.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _products[index].price = double.parse(value);
                              });
                              _updateTotalAmount();
                            },
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Quantity',
                            ),
                            initialValue: _products[index].quantity.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _products[index].quantity = int.parse(value);
                              });
                              _updateTotalAmount();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount:'),
                  Text('\$$_totalAmount'),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addProduct,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}