import 'package:flutter/material.dart';

class CustomPassword extends StatelessWidget {
  const CustomPassword({Key? key , this.userPassword}) : super(key: key);

  final userPassword;
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
          child:Column(
            children: <Widget>[
              Row(
                children: [
                  Icon(Icons.lock_outline,size: 24.0,color: Colors.grey,semanticLabel: 'Email icon'),
                  Padding(padding: const EdgeInsets.only(left: 10.0),
                    child: Text('비밀번호',
                      style: TextStyle(color: Color(0xff868686),fontSize: 16.0),),
                  ),

                ],
              ),
              TextField(
                onChanged: (value){
                  userPassword(value);
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),

                    suffixText: '보기',
                    suffixStyle: TextStyle(color: Color(0xff5956E9))
                ),
                obscureText: true,
              )
            ],
          ),
        )
    );
  }
}
