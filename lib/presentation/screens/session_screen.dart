import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/session_error_model.dart';
import 'package:quran/presentation/blocs/session/session_bloc.dart';
import 'package:quran/presentation/blocs/session/session_event.dart';
import 'package:quran/presentation/blocs/session/session_state.dart';

class SessionScreen extends StatefulWidget {
  final String studentName;
  final int startPage;
  final int endPage;

  const SessionScreen({
    super.key,
    required this.studentName,
    required this.startPage,
    required this.endPage,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  @override
  void initState() {
    super.initState();

    context.read<SessionBloc>().add(
      StartSession(
        studentName: widget.studentName,
        startPage: widget.startPage,
        endPage: widget.endPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            color: const Color(0xFF2b836b), // الخلفية الخضراء
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment
                      .topRight, // أو Alignment.topLeft للغة الإنجليزية
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                

                Spacer(),
                // المؤقت الدائري
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2b836b),
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatDuration(state.duration),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'الصفحة ${state.currentPage}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // الأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _customButton('إنهاء الجلسة', () {
                      context.read<SessionBloc>().add(EndSession());
                      Navigator.pop(context);
                    }),
                    _customButton('إنهاء الصفحة', () {
                      context.read<SessionBloc>().add(EndPage());
                    }),
                    _customButton('إضافة خطأ', () async {
                      final SessionErrorModel? error = await _showErrorDialog(
                        context,
                      );
                      if (error != null) {
                        context.read<SessionBloc>().add(AddError(error));
                      }
                    }),
                  ],
                ),
                const SizedBox(height: 32),
                // معلومات الجلسة
                _SessionDetails(state: state),
                const Spacer(),
              ],
            ),
          );
        },
      ),
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

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  Future<SessionErrorModel?> _showErrorDialog(BuildContext context) async {
    final errors = await context.read<SessionBloc>().repository.fetchErrors();

    return showDialog<SessionErrorModel>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اختر الخطأ'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: errors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(errors[index].description),
                  onTap: () => Navigator.pop(context, errors[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _SessionDetails extends StatelessWidget {
  final SessionState state;
  const _SessionDetails({required this.state});

  @override
  Widget build(BuildContext context) {
    final heardPages = state.endPage - state.startPage;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'اسم الطالب',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      state.studentName,
                    ), // اسم ثابت حالياً، غيّره حسب ما تريد
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'الكمية المسمعة',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('$heardPages صفحات'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _pageLabel('الصفحة ${state.endPage}'),
              _pageLabel('الصفحة ${state.startPage}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}
