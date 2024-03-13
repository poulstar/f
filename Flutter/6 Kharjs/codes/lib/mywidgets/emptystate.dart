import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 72.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/empty state.png',
          width: 240,
          height: 240,
        ),
        const SizedBox(
          width: 240,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'لیست خرجهای شما خالیست',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
