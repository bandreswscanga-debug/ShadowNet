import 'package:flutter/material.dart';
import '../../widgets/terminal_text.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  static const List<String> _lines = [
    ">> Operador autenticado...",
    ">> Escaneando nodos cercanos...",
    ">> Sistema listo.",
  ];

  final List<String> _visibleLines = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animateLines();
  }

  Future<void> _animateLines() async {
    for (final line in _lines) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      setState(() => _visibleLines.add(line));
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHADOWNET TERMINAL"), // hereda estilo del AppBarTheme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: _visibleLines.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, index) => TerminalText(text: _visibleLines[index]),
        ),
      ),
    );
  }
}