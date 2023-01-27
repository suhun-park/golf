import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/privider/model_main_benner_provider.dart';
import 'package:golf_booking/privider/model_place_provider.dart';
import 'package:golf_booking/routes/routes.dart';
import 'package:golf_booking/user/models/model_auth.dart';

//한글로 변경하기
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: 'fec0f2a42d84db29501544331c0cf23c',javaScriptAppKey: '19f7be6f5689b78423cdbfd506762743');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();

  // /// 데이터 베이스를 불러온다 . 데이터베이스 생성
  // final database = LocalDatabase();
  //
  // /// GetIt을 통해서 어디서든 database를 가져올수 있다.
  // GetIt.I.registerSingleton<LocalDatabase>(database);
  //
  // /// getCategoryColors() 함수를 실행해서 데이터베이스에서 컬러를 가져왔다.
  // final colors = await database.getCategoryColors();
  //
  // /// colors에 데이터가 없으면 DEFAULT_COLORS의 색상을 생성해준다.
  // /// 한번 넣으면 프로그램 삭제될때까지 추가하지 않아도 된다.
  // /// isEmpty 가 false 로 변함
  // if(colors.isEmpty){
  //   for(String hexCode in DEFAULT_COLORS){
  //     await database.createCategoryColor(
  //       CategoryColorsCompanion(
  //         hexCode: Value(hexCode),
  //       ),
  //     );
  //   }
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => PlaceProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 0.9,
          ),
          child: child!,
        ),
        debugShowCheckedModeBanner: false,
        title: '파크고',
        theme: ThemeData(
          primaryColor: Styles.backgroundColor,
          primaryColorLight: Colors.white,
          fontFamily: 'Raleway',
        ),
        initialRoute: 'splash',
        routes: getApplicationRoutes(),
      ),
    );
  }
}
