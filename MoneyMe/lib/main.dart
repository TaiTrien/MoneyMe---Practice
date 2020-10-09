import 'package:MoneyMe/blocs/auth/auth_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'blocs/jars/jarbloc_bloc.dart';
import 'blocs/transaction/transaction_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<JarBloc>(
          create: (context) => JarBloc(),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<TagBloc>(
          create: (context) => TagBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: kSecondaryColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/loadingScreen',
        routes: routes,
      ),
    );
  }
}
