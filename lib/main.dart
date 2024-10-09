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
        title: 'Gundam Data',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(172, 255, 0, 0)),
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
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Action for info button
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Action for settings button
            },
          ),
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(
                      statement.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date),
                      style: const TextStyle(color: Color.fromARGB(255, 180, 233, 95)),
                    ),
                    leading: CircleAvatar(
                      radius: 30, // ขนาดเพิ่มขึ้นเพื่อความชัดเจน
                      backgroundColor:
                          const Color.fromARGB(255, 240, 12, 12), 
                      child: FittedBox(
                        child: Text(
                          statement.pilot.isNotEmpty
                              ? statement.pilot[0]
                                  .toUpperCase() 
                              : '?', 
                          style: const TextStyle(
                            color: Color.fromARGB(255, 57, 41, 146),
                            fontWeight: FontWeight.bold,
                            fontSize: 20, 
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TransactionDetailScreen(transaction: statement);
                      }));
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Transaction'),
                              content: const Text(
                                  'Are you sure you want to delete this transaction?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    provider.deleteTransaction(index);
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );
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
