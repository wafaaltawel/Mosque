import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/session_error_model.dart';
import 'package:quran/presentation/blocs/session/session_bloc.dart';
import 'package:quran/presentation/blocs/session/session_event.dart';
import 'package:quran/presentation/blocs/session/session_state.dart';

class SessionScreen extends StatefulWidget {
  final int studentid;
  final String studentName;
  final int startPage;
  final int endPage;

  const SessionScreen({
    super.key,
    required this.studentName,
    required this.startPage,
    required this.endPage,
    required this.studentid,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SessionBloc>().add(
      StartSession(
        studentName: widget.studentName,
        startPage: widget.startPage,
        endPage: widget.endPage,
        studentid: widget.studentid,
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
            color: const Color(0xFF2b836b),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2b836b),
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
    final TextEditingController pageController = TextEditingController();
    SessionErrorModel? selectedError;

    return showDialog<SessionErrorModel>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'إضافة خطأ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text("اختر نوع الخطأ:"),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: errors.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<SessionErrorModel>(
                            title: Text(errors[index].title),
                            value: errors[index],
                            groupValue: selectedError,
                            onChanged: (value) {
                              setState(() {
                                selectedError = value;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: pageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'رقم الصفحة',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedError == null ||
                                pageController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("اختر الخطأ وأدخل رقم الصفحة"),
                                ),
                              );
                              return;
                            }

                            final int page =
                                int.tryParse(pageController.text) ?? 0;

                            final errorWithPage = SessionErrorModel(
                              id: selectedError!.id,
                              campaignId: selectedError!.campaignId,
                              title: selectedError!.title,
                              removedPoints: selectedError!.removedPoints,
                              pageNumber: page,
                            );

                            Navigator.pop(context, errorWithPage);
                          },
                          child: const Text('إضافة'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
    final heardPages = state.currentPage - state.startPage;


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
                    Text(state.studentname),
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
