import 'package:flutter/material.dart';

const List<String> messages = [
  'به اپلیکیشن kharjs خوش آمدید \n برای توضیحات برنامه، صفحه را از راست به چپ بکشید',
  'برای افزودن خرج، نوشتن قیمت و عنوان اجباریست',
  'برای ویرایش یک خرج، با ضربه زدن روی آن، میتوانید آن را ویرایش کنید',
  'برای حذف یک خرج، ابتدا باید چک باکس آن را فعال نمایید. پس از فعال بودن چک باکس "ثبت شد" یک خرج، با نگه داشتن انگشتتان روی آن ردیف میتوانید آن را به صورت دایم حذف کنید',
  'با فشردن دکمه شمسی یا میلادی، میتوانید نحوه نمایش تاریخ ها را به شمسی یا میلادی تغییر دهید',
  'برای شروع کار با برنامه، یک بار برنامه را بسته و مجددا باز کنید',
  '😊موفق باشید😊',
];

class FirstTimeWidget extends StatelessWidget {
  const FirstTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("توضیحات اولیه"),
        backgroundColor: Colors.purple.shade700,
        centerTitle: true,
      ),
      body: PageView(children: [
        for (var i = 0; i < messages.length; i++)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.lightBlue[300 + i * 100],
            child: Center(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      messages[i],
                      textAlign: TextAlign.center,
                    ))),
          ),
      ]),
    );
  }
}

//  OR
// class FirstTimeWidget extends StatelessWidget {
//   const FirstTimeWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("توضیحات اولیه"),
//         backgroundColor: Colors.purple.shade700,
//         centerTitle: true,
//       ),
//       body: PageView(children: [
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade300,
//           child: const Center(child: Text('\nبرای توضیحات برنامه، صفحه را از راست به چپ بکشید به اپلیکیشن kharjs خوش آمدید')),
//         ),
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade400,
//           child: const Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     'برای افزودن خرج، نوشتن قیمت و عنوان اجباریست',
//                     textAlign: TextAlign.center,
//                   ))),
//         ),
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade500,
//           child: const Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     'برای ویرایش یک خرج، با ضربه زدن روی آن، میتوانید آن را ویرایش کنید',
//                     textAlign: TextAlign.center,
//                   ))),
//         ),
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade600,
//           child: const Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     'برای حذف یک خرج، ابتدا باید چک باکس آن را فعال نمایید. پس از فعال بودن یک خرج، با نگه داشتن انگشتتان روی آن میتوانید آن را به صورت دایم حذف کنید',
//                     textAlign: TextAlign.center,
//                   ))),
//         ),
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade700,
//           child: const Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     'با فشردن دکمه شمسی یا میلادی، میتوانید نحوه نمایش تاریخ ها را به شمسی یا میلادی تغییر دهید',
//                     textAlign: TextAlign.center,
//                   ))),
//         ),
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade800,
//           child: const Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     'برای شروع کار با برنامه، یک بار برنامه را بسته و مجددا باز کنید',
//                     textAlign: TextAlign.center,
//                   ))),
//         ),
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.lightBlue.shade900,
//           child: const Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     '😊موفق باشید😊',
//                     textAlign: TextAlign.center,
//                   ))),
//         ),
//       ]),
//     );
//   }
// }
