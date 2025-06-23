import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/session/session_bloc.dart';
import 'package:quran/presentation/blocs/session/session_event.dart';
import 'package:quran/presentation/blocs/session/session_state.dart';
import 'package:quran/presentation/widgets/session_screen_widgets/session_buttons.dart';
import 'package:quran/presentation/widgets/session_screen_widgets/session_ditels.dart';
import 'package:quran/presentation/widgets/session_screen_widgets/session_timer.dart';
import 'package:quran/presentation/widgets/session_screen_widgets/showErrorDialog.dart';


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
                SessionTimer(
                  time: _formatDuration(state.duration),
                  currentPage: state.currentPage,
                ),
                const SizedBox(height: 32),
                SessionButtons(
                  onEndSession: () {
                    context.read<SessionBloc>().add(EndSession());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل الجلسة بنجاح'), backgroundColor: Colors.green),
                    );
                    Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context, true));
                  },
                  onEndPage: () => context.read<SessionBloc>().add(EndPage()),
                  onAddError: () => showErrorDialog(context).then((error) {
                    if (error != null) {
                      context.read<SessionBloc>().add(AddError( error));
                    }
                  }),
                ),
                const SizedBox(height: 32),
                SessionDetails(state: state),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
