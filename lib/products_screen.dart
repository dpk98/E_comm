import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_comm/models/user_data.dart';
import 'package:e_comm/models/products_data.dart';

class ProductListPage extends StatefulWidget {
  final UserDetails userDetails;

  const ProductListPage({
    super.key,
    required this.userDetails,
  });

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool _isGridMode = false;
  List<ProductData> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final productList = ProductList.fromJson(jsonResponse);
        setState(() {
          products = productList.products;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Wrap(
          direction: Axis.horizontal,
          children: [
            Text(
              '${widget.userDetails.username}',
            ),
            Text(
              'UserName',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFeatures: [FontFeature.superscripts()],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_isGridMode ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridMode = !_isGridMode;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.userDetails.image!),
            ),
            Text(
              '${widget.userDetails.firstName} ${widget.userDetails.lastName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text('Email_Id: ${widget.userDetails.email}'),
            Expanded(
              child: _isGridMode ? _buildGridView() : _buildListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: Colors.white,
          ),
          child: ListTile(
            leading: Image.network(
              products[index].images[0],
              width: 80,
            ),
            title: Text(
              products[index].title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Text(
                  '\$${products[index].price}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('${products[index].discountPercentage}% off'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  height: 80,
                  width: 150,
                  child: Image.network(
                    products[index].images[0],
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  products[index].title.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$${products[index].price}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('${products[index].discountPercentage}% off'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
