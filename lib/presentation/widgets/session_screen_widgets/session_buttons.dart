import 'package:flutter/material.dart';

class SessionButtons extends StatelessWidget {
  final VoidCallback onEndSession;
  final VoidCallback onEndPage;
  final VoidCallback onAddError;

  const SessionButtons({
    required this.onEndSession,
    required this.onEndPage,
    required this.onAddError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _customButton('إنهاء الجلسة', onEndSession),
        _customButton('إنهاء الصفحة', onEndPage),
        _customButton('إضافة خطأ', onAddError),
      ],
    );
  }

  Widget _customButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
