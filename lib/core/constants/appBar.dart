import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/main_bloc.dart';
import 'package:quran/presentation/blocs/main_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF2b836b),
      elevation: 0,
      centerTitle: true,
      title: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoaded) {
            return Text(
              state.data.mosqueName,
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
