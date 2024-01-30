import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product{
  String search_image;
  String styleid;
  String brands_filter_facet;
  String price;
  String product_additional_info;
  Product(
      {
        required this.search_image,
        required this.styleid,
        required this.brands_filter_facet,
        required this.price,
        required this.product_additional_info
      }
      );
}

class ProductListScreen extends StatefulWidget{
  @override
  _ProductListScreenState createState() =>  _ProductListScreenState();

}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = [];
    fetchProducts();//ham lay du lieu tu server
  }
  //ham doc du lieu tu server
  Future<void> fetchProducts() async {
      final response = await http.get(
          Uri.parse("http://192.168.10.104:8080/aserver/api.php"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          products = converMapToList(data);
        });
      }
      else {
        throw Exception("khong doc duoc du lieu");
      }

  }
  //ham convert Map thanh list
  List<Product> converMapToList(Map<String,dynamic>data)
  {
    List<Product> productList=[];
    data.forEach((key, value) {
      for(int i=0;i<value.length;i++)
      {
        Product product=Product(
            search_image:value[i] ['search_image'] ?? '',
            styleid:value[i] ['styleid'] ?? 0,
            brands_filter_facet:value[i] ['brands_filter_facet'] ?? '',
            price:value[i] ['price'] ?? 0,
            product_additional_info:value[i] ['product_additional_info'] ?? '');
        productList.add(product);
      }
    }
    );
    return productList;
  }
  //tao layout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sach san pham"),
      ),
      body: products != null ?
      ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(products[index].brands_filter_facet),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${products[index].price}'),
                  Text('product_additional_info: ${products[index].product_additional_info}'),
                ],
              ),
              leading: Image.network(
                products[index].search_image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
                onTap: (){//click vao item
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> ProductDetailScreen(products[index]),
                    ),
                  );
                },
            );
          })
          :Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen(this.product);
//giao dien
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=> CardScreen()),);
          },
            child: Icon(Icons.shopping_cart),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(0)
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(8),
            child: Text('Brand: ${product.brands_filter_facet}'),
          ),
          Padding(padding: const EdgeInsets.all(8),
            child: Text('Price: ${product.price}'),
          ),
          Padding(padding: const EdgeInsets.all(8),
            child: Text('ID: ${product.styleid}'),
          ),
          Padding(padding: const EdgeInsets.all(8),
            child: Text('Infor: ${product.product_additional_info}',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
          Image.network(product.search_image,
              width: 500,
              height: 500,
              fit: BoxFit.cover)
        ],
      ),
    );
  }

}
class CardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("shopping Cart"),),
      body: Center(
        child: Text('Gio hang cua ban'),
      ),
    );
  }

}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danh sach san pham',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      //ProductListScreen(),
    );
  }
}
//dinh nghia homeScreen
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chu"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductListScreen()),);
          },
          child: Text("Go to ProductListScreen"),
        ),
      ),
    );

  }

}

