import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_state.dart';

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
                Container(
                  color: Color(0xFFD6E9F9), // لون أزرق فاتح مشابه للصورة
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "تقوم هذه الصفحة بعرض جميع جلسات التسميع لليوم المحدد",
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      // Icon(Icons.close, color: Colors.blue.shade200),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.teal, // لون الزر الأخضر المزرق
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "بدء جلسة تسميع",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "جلسات التسميع",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      // الأيقونة على اليسار (أو اليمين حسب اتجاه الواجهة)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(Icons.calendar_today, color: Colors.teal),
                      ),
                      const SizedBox(width: 10),

                      // حقل إدخال اسم الطالب
                      Expanded(
                        child: TextField(
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: "اسم الطالب",
                            hintTextDirection: TextDirection.rtl,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.listening.length,
                    itemBuilder: (context, index) {
                      final data = state.listening[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios,
                                    size: 10,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    data.teacherName,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),
                              Wrap(
                                spacing: 6,
                                children: [
                                  Container(
                                    // padding: const EdgeInsets.symmetric(
                                    //   horizontal: 12,
                                    //   vertical: 4,
                                    // ),
                                    decoration: BoxDecoration(
                                      color: data.isPassed
                                          ? Colors.green[50]
                                          : Colors.red[50],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      data.isPassed ? 'ناجح' : 'راسب',
                                      style: TextStyle(
                                        color: data.isPassed
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.points} نقطة",
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 11,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    "${data.time} دقائق",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 11,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    data.studentName,
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
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
