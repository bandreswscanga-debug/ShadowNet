import 'package:flutter/material.dart';

void main() {
  runApp(const ShadowNetApp());
}

class ShadowNetApp extends StatelessWidget {
  const ShadowNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadowNet',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShadowNet'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bienvenido a ShadowNet', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text('Has presionado el botón $_counter veces.'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _increment,
              icon: const Icon(Icons.add),
              label: const Text('Incrementar'),
            )
          ],
        ),
      ),
    );
  }
}
