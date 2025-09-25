import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/counter_provider.dart';
import 'widgets/counter_tile.dart';

// Entry point aplikasi
void main() {
  // Wrap MyApp dengan ChangeNotifierProvider agar CounterProvider
  // bisa diakses di seluruh aplikasi (global state)
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

/// Root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Best Practice Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CounterListScreen(),
    );
  }
}

/// Halaman utama yang menampilkan daftar counter
class CounterListScreen extends StatelessWidget {
  const CounterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance CounterProvider
    final model = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Advanced Counter App")),
      body: model.counters.isEmpty
          // Jika belum ada counter, tampilkan teks petunjuk
          ? const Center(child: Text("Belum ada counter, klik tombol +"))
          // Jika ada counter, tampilkan dalam ReorderableListView
          : ReorderableListView(
              onReorder: model.reorder,
              children: [
                for (int i = 0; i < model.counters.length; i++)
                  CounterTile(
                    key: ValueKey(
                      model.counters[i],
                    ), // Key unik agar reorder aman
                    index: i,
                  ),
              ],
            ),
      // Tombol tambah counter
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: model.addCounter,
      ),
    );
  }
}
