import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/data/news_api_client.dart';
import 'package:news_app/data/news_respostory.dart';
import 'package:news_app/viewmodel/favorite_tr.dart';
import 'package:news_app/viewmodel/favorite_us.dart';
import 'package:news_app/viewmodel/viewmodel.dart';
import 'package:news_app/widgets/home.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => NewsApiClient());
  getIt.registerLazySingleton(() => NewsRespoStory());
}

void main() {
  setup();
  initializeDateFormatting('tr');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.red),
          tabBarTheme: const TabBarTheme(labelColor: Colors.white)),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NewsViewModel()),
          ChangeNotifierProvider(
            create: (context) => FavViewModel(),
          ),
          ChangeNotifierProvider(create: (context) => FavTrViewModel(),),
        ],
        child: Home(),
      ),
    );
  }
}
