
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_state.dart';
import 'package:quran/presentation/widgets/listening_widgets/listeninginfobanner.dart';
import 'package:quran/presentation/widgets/listening_widgets/listeningsessioncard.dart';
import 'package:quran/presentation/widgets/listening_widgets/startsessionbuttonandtitle.dart';
import 'package:quran/presentation/widgets/listening_widgets/studentnamefilterinput.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

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
               // const StudentNameFilterInput(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.listening.length,
                    itemBuilder: (context, index) {
                      return ListeningSessionCard(data: state.listening[index]);
                    },
                  ),
                ),
              ],
            );
          } else if (state is ListeningError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
