import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/main_bloc.dart';
import '../../blocs/main_state.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF2b836b),
      elevation: 0,
      centerTitle: true,
      title: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoaded) {
            return Text(
              state.data.otherMosqueNames ??"لا يوجد",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          return const Text("", style: TextStyle(color: Colors.black));
        },
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(Icons.menu, color: Colors.black),
        ),
      ],
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(Icons.notifications_none, color: Colors.black),
      ),
    );
  }
}
