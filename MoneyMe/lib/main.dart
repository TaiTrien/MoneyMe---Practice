import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/loadingScreen',
        routes: routes,
      ),
    );
  }
}
