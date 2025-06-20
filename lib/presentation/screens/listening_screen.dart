import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_event.dart';
import 'package:quran/presentation/blocs/listening/listening_state.dart';
import 'package:quran/presentation/widgets/listening_widgets/listeninginfobanner.dart';
import 'package:quran/presentation/widgets/listening_widgets/listeningsessioncard.dart';
import 'package:quran/presentation/widgets/listening_widgets/startsessionbuttonandtitle.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  @override
  void initState() {
    super.initState();
    // عند بدء الشاشة، اطلب تحميل بيانات التسميع
    context.read<ListeningBloc>().add(LoadListening());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fb),
      body: BlocBuilder<ListeningBloc, ListeningState>(
        builder: (context, state) {
          if (state is ListeningLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListeningLoaded) {
            return Column(
              children: [
                const ListeningInfoBanner(),
                const StartSessionButtonAndTitle(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ListeningBloc>().add(LoadListening());
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(), // يسمح بالسحب دائمًا
                      itemCount: state.listening.length,
                      itemBuilder: (context, index) {
                        return ListeningSessionCard(data: state.listening[index]);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ListeningError) {
            return Center(child: Text(state.message));
          }

          // حالة البداية أو أي حالة غير متوقعة
          return const SizedBox();
        },
      ),
    );
  }
}
