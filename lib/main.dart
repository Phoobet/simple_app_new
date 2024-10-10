import 'package:flutter/material.dart';
import 'package:app/screen/HomeScreen.dart';
import 'package:app/screen/form_screen.dart';
import 'package:provider/provider.dart';
import 'package:app/provider/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 245, 0, 0)),
          useMaterial3: true,
        ),
        home: MyHomePage(), // เพิ่มส่วนนี้เพื่อระบุหน้าเริ่มต้น
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [Homescreen(), FormScreen()],
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(
                text: "List of Information",
                icon: Icon(Icons.list),
              ),
              Tab(
                text: "Add information",
              )
            ],
          ),
        ));
  }
}
