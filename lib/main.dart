import 'package:flutter/material.dart';
import 'package:simple_app/screen/HomeScreen.dart';
import 'package:simple_app/screen/form_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 17, 255)),
          useMaterial3: true,
        ),
        home: MyHomePage(), // ระบุหน้าเริ่มต้น
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
        // Set the background color for the entire Scaffold
        backgroundColor: const Color.fromARGB(255, 10, 207, 233), 
        body: Container(
          // Set the background color for the TabBarView
          color: const Color.fromARGB(255, 18, 240, 248), 
          child: TabBarView(
            children: [Homescreen(), FormScreen()],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: [
              Tab(
                text: "List of Information",
                icon: Icon(Icons.list),
              ),
              Tab(
                text: "Add information",
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
