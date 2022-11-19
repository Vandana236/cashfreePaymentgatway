import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var amountController=TextEditingController();








  Future<dynamic> gettken()async{
    Map data={
      'orderId':'Order0001',
      'orderAmount':'100',
      'orderCurrency':'INR'

    };
    var resonse=await http.post(Uri.parse('https://test.cashfree.com/api/v2/cftoken/order'),
    body:data

    );
    if(resonse.statusCode==200){
      return json.decode(resonse.body);
    }else{
      return 'error';
    }
  // if(response)
  }


  void getToken()async{
    String token=await gettken();
    buttonHendlerTab(token);
  }

  Function? buttonHendlerTab(token) {
    Map<String,String> inputparams = {

    "orderId": "sdgfg456fbfhffdhvnb_dfgfdg",
    "orderAmount": "6000",
    "customerName": "vandana",
    "orderNote": "this is the optional field",
    "orderCurrency": "INR",
    "appId": "570879b453f61baac07f0548078075",
    "customerPhone": "9389953262",
    "customerEmail": "vandana2verma786@gmil.com",
    "stage": "Test",
    "notifyUrl": "",
      "tokenData":token

    };
    CashfreePGSDK.doPayment(inputparams)
    .then((value) {
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("CashFree payment"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child:  TextField(
              controller: amountController,
              decoration: InputDecoration(
                hintText: "enter your amount",
              ),
            ),
          ),
          CupertinoButton(
          color: Colors.green,
          child:  Text('Pay'),
            onPressed: (){
              getToken();
            }
          )
        ],
      ),
    );
  }
}
