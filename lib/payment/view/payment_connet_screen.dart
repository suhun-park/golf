import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

import '../model/payment_model.dart';

class PaymentConnet extends StatelessWidget {
   PaymentConnet({required this.pay,required this.user,Key? key}) : super(key: key);
  int pay;
  PaymentModel user;

  @override
  Widget build(BuildContext context) {

    return IamportPayment(
      initialChild: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text("잠시만 기달려주세요"),
                )
              ],
            ),
          ),
        ),
      ),
      userCode: 'iamport',
      data: PaymentData(
          pg: 'html5_inicis',
          payMethod: 'card',
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
          amount: 4000,
          buyerTel: user.buyerTel,
          appScheme: 'example',
          buyerName: user.buyerName,

      ),
      callback: (Map<String, String>result){
        Navigator.pop(context);
    }

    );
  }
}




