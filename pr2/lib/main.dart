import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ung dung tinh tong',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyCal(),


    );
  }
}
class MyCal extends StatefulWidget{
  @override
  MyCalState createState() {
    return MyCalState();
  }

}
class MyCalState extends State<MyCal>{
  TextEditingController numControl1 = TextEditingController();
  TextEditingController numControl2 = TextEditingController();
  String kq='';
  void tinhTong(){
    double num1 = double.tryParse(numControl1.text) ?? 0.0;
    double num2 = double.tryParse(numControl2.text) ?? 0.0;
    double num = num1 + num2;
    setState(() {
      kq='tong: $num';
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResulScreen(kq),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tinh tong')),
      body: Padding(padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(controller: numControl1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Nhap so 1'),),
          TextField(controller: numControl2, keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Nhap so 2'),),
          SizedBox(height: 10),
          ElevatedButton(onPressed: tinhTong, child: Text('Tinh tong')),
          SizedBox(height: 10),
        ]),
      ),
    );
  }

}
class ResulScreen extends StatelessWidget{
  final String result;
  ResulScreen(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ket qua tinh tong')),
      body: Center(child: Text(result,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
    );
  }
}
