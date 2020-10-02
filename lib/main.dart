import 'package:flutter/material.dart';
import 'package:marvel/app/service/api_keys.dart';
import 'package:marvel/app/service/api_service.dart';
import 'package:provider/provider.dart';

import 'app/service/api.dart';
import 'app/ui/marvel_home_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<APIService>(
      create: (_) => APIService(
        api: API(),
        publicKey: APIKeys.publicKey,
        privateKey: APIKeys.privateKey,
      ),
      child: MaterialApp(
        title: 'Marvel',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MarvelHomePage(),
      ),
    );
  }
}
