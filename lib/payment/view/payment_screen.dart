import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/payment/view/payment_connet_screen.dart';

import '../model/payment_model.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentBody(),

    );
  }
}
class PaymentBody extends StatelessWidget {
  const PaymentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Container(
        child: TextButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PaymentConnet(
              pay:3000,
                user:PaymentModel(
                buyerEmeil: '123',
                buyerName: '123',
                buyerPostCode: '123',
                buyerTel: '123'
            ),
            )));
          },
          child: Text("결제 구현"),

        )
      ),
      )
    );
  }
}

