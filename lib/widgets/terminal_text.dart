import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TerminalText extends StatefulWidget {
  final String text;
  final int typingSpeedMs;
  final bool showCursor;

  const TerminalText({
    super.key,
    required this.text,
    this.typingSpeedMs = 40,
    this.showCursor = true,
  });

  @override
  State<TerminalText> createState() => _TerminalTextState();
}

class _TerminalTextState extends State<TerminalText>
    with SingleTickerProviderStateMixin {
  String _displayed = '';
  bool _cursorVisible = true;
  bool _typingDone = false;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (!mounted) return;
        if (status == AnimationStatus.completed) {
          _cursorController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _cursorController.forward();
        }
        setState(() => _cursorVisible = !_cursorVisible);
      });

    _cursorController.forward();
    _typeText();
  }

  Future<void> _typeText() async {
    for (int i = 0; i <= widget.text.length; i++) {
      await Future.delayed(Duration(milliseconds: widget.typingSpeedMs));
      if (!mounted) return;
      setState(() => _displayed = widget.text.substring(0, i));
    }
    setState(() => _typingDone = true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final cursor = widget.showCursor && _cursorVisible ? '█' : ' ';

    return Text(
      _typingDone ? _displayed : '$_displayed$cursor',
      style: GoogleFonts.robotoMono(
        color: color,
        fontSize: 16,
      ),
    );
  }
}