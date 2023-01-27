import 'package:flutter/material.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/payment/view/payment_screen.dart';

class Splash_Screen extends StatelessWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return (Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(51.0, 70.0, 0.0, 0.0),
              child: Center(
                child: Text('파크고에서 \n골프예약과 \n장비 구매까지',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                child: Container(
                    child: const Image(
                        image: AssetImage('assets/images/customlogo.png'),
                        fit: BoxFit.contain))),
            SizedBox(height: 40.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Styles.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 22,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, "auth-index");
                //Navigator.pushReplacementNamed(context, "/");
                Navigator.push(context,MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
              child: const Text('시작하기'),
            )
          ],
        ),
      ),
    ));
  }
}
