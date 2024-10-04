import 'package:flutter/material.dart';
import 'package:simple_app/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';
import 'package:simple_app/screens/transactiondetailScreen.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(255, 0, 0, 1)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Gundam Data'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormScreen();
              }));
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return const Center(
              child: Text(
                'No Gundam Data Available',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                var statement = provider.transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(statement.title),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('${statement.pilot}'),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return TransactionDetailScreen(transaction: statement);
                      }));
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteTransaction(index);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
