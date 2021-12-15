import 'package:devslab/base_class.dart';
import 'package:devslab/models/product.dart';
import 'package:devslab/screens/product_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with BaseClass {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      loadData();
    });
  }

  void loadData() async {
    var response = await Dio().get(baseUrl + "shops/?country_id=1");
    setState(() {
      _products = (response.data['data'] as Iterable)
          .map((product) => Product.fromJson(product['sales']))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: _products.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 3,mainAxisSpacing: 3),
        itemBuilder: (context, index) {
          var product = _products[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProductDetails(product:product)));
            },
            child: Column(
              children: [
                Expanded(child: Image(image: NetworkImage(product.image))),
                Text(product.name),
                Text("${product.price}",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange
                ),),
              ],
            ),
          );
        },
      ),
    );
  }
}
