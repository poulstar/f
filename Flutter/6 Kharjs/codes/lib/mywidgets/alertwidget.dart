import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, var box) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Directionality(
        textDirection: TextDirection.rtl, child: Text("حذف تمامی خرج ها!!!")),
    backgroundColor: Colors.yellow,
    content: const Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        "با فشردن تایید، تمامی خرج ها به طور دایم حذف خواهند شد. مطمئنید؟",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            box.clear();
          },
          child: const Text(
            'تایید',
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'انصراف',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 36,
            ),
          ),
        ),
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
