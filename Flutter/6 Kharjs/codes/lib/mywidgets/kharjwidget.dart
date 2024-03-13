import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data.dart';

class KharjWidget extends StatefulWidget {
  final String title;

  const KharjWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<KharjWidget> createState() => _KharjWidgetState();
}

class _KharjWidgetState extends State<KharjWidget> {
  late var priceController = TextEditingController();
  late var titleController = TextEditingController();
  late var descriptionController = TextEditingController();
  var priceFocusNode = FocusNode();
  var titleFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF271C9D),
                  Color(0xFF000F2D),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF000F2D),
                Color(0xFF271C9D),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  child: Row(
                    children: [
                      const Text("تومان"),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => setState(() {}),
                          focusNode: priceFocusNode,
                          textInputAction: TextInputAction.next,
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          textAlign: TextAlign.center,
                          // برای وسط نوشتن متن
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // برای این که خط زیرش رو برداره.
                            hintText: "قیمت",
                            counterText: "",
                            // برای این که زیر سمت راست نیاره چند تا کاراکتر باقیمونده.
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                            errorText: priceController.text == ""
                                ? "قیمت را وارد کنید"
                                : "",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  onChanged: (value) => setState(() {}),
                  focusNode: titleFocusNode,
                  textInputAction: TextInputAction.next,
                  controller: titleController,
                  maxLength: 64,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    hintText: 'عنوان',
                    counterText: '',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    errorText:
                        titleController.text == "" ? "عنوان را وارد کنید" : "",
                  ),
                  minLines: 1,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                        // این رو اول برای قیمت و عنوان هم گذاشته بودم اما وقتی بهشون errorText میدیم این دیگه نمایش داده نمیشه.
                        borderSide: BorderSide(
                      color: Colors.green,
                      width: 1,
                    )),
                    hintText: "توضیحات",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 16,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (priceController.text.isEmpty) {
                            SnackBar errorSnackBar = const SnackBar(
                              backgroundColor: Colors.red,
                              showCloseIcon: true,
                              content: Center(child: Text('قیمت را وارد کنید')),
                              duration: Duration(seconds: 2),
                              elevation: 5,
                              padding: EdgeInsets.all(8),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorSnackBar);
                            FocusScope.of(context).requestFocus(priceFocusNode);
                            return;
                          } else if (titleController.text.isEmpty) {
                            SnackBar errorSnackBar = const SnackBar(
                              backgroundColor: Colors.orange,
                              showCloseIcon: true,
                              content:
                                  Center(child: Text('عنوان را وارد کنید')),
                              duration: Duration(seconds: 2),
                              elevation: 5,
                              padding: EdgeInsets.all(8),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorSnackBar);
                            FocusScope.of(context).requestFocus(titleFocusNode);
                            return;
                          }
                          Kharj kharj = Kharj();
                          kharj.price = int.parse(priceController.text);
                          kharj.title = titleController.text;
                          kharj.description = descriptionController.text;
                          Box<Kharj> box = Hive.box('kharjs');
                          box.add(kharj);
                          SnackBar errorSnackBar = SnackBar(
                            backgroundColor: Colors.green,
                            showCloseIcon: true,
                            content: Center(
                                child: Text(
                                    '${titleController.text} با موفیت ثبت شد')),
                            duration: const Duration(seconds: 2),
                            elevation: 5,
                            padding: const EdgeInsets.all(8),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(errorSnackBar);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.green.shade900)),
                        child: const ClipRRect(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12.0),
                            child: Text(
                              'تایید و ثبت',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          reset();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue.shade900),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 6.0),
                          child: Text(
                            'پاک کردن نوشته ها',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void reset() {
    priceController.text = '';
    titleController.text = '';
    descriptionController.text = '';
    FocusScope.of(context).requestFocus(priceFocusNode);
  }
}