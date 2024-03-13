import 'package:flutter/material.dart';
import 'package:kharjs/main.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../data.dart';
import '../myfunctions.dart';

DateTime now = DateTime.now();
class KharjWidgetUpdate extends StatefulWidget {
  final String title;
  final Kharj kharj;

  const KharjWidgetUpdate(
      {Key? key, required this.title, required this.kharj})
      : super(key: key);

  @override
  State<KharjWidgetUpdate> createState() => _KharjWidgetUpdateState();
}

class _KharjWidgetUpdateState extends State<KharjWidgetUpdate> {
  late var priceController = TextEditingController(text: widget.kharj.price.toString());
  late var titleController = TextEditingController(text: widget.kharj.title);
  late var descriptionController = TextEditingController(text: widget.kharj.description);
  late var dateController = TextEditingController(text: myJalaliMaker(widget.kharj.dateTime));
  var priceFocusNode = FocusNode();
  var titleFocusNode = FocusNode();
  var dateFocusNode = FocusNode();

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
                  textInputAction: TextInputAction.next,
                  focusNode: titleFocusNode,
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
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      children: [
                        const Text('تاریخ'),
                        Expanded(
                          child: TextField(
                            controller: dateController,
                            cursorColor: Colors.blue,
                            focusNode: dateFocusNode,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.datetime,
                            maxLength: 10,
                            style: const TextStyle(fontSize: 32),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        reset();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blue.shade900),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
                        child: Text(
                          'اصلاح مجدد',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (priceController.text.isEmpty){
                          SnackBar errorSnackBar = const SnackBar(
                            backgroundColor: Colors.red,
                            showCloseIcon: true,
                            content: Center(child: Text('قیمت را وارد کنید')),
                            duration: Duration(seconds: 2),
                            elevation: 5,
                            padding: EdgeInsets.all(8),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                          FocusScope.of(context).requestFocus(priceFocusNode);
                          return;
                        }
                        else if(titleController.text.isEmpty){
                          SnackBar errorSnackBar = const SnackBar(
                            backgroundColor: Colors.orange,
                            showCloseIcon: true,
                            content: Center(child: Text('عنوان را وارد کنید')),
                            duration: Duration(seconds: 2),
                            elevation: 5,
                            padding: EdgeInsets.all(8),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                          FocusScope.of(context).requestFocus(titleFocusNode);
                          return;
                        }
                        try {
                          widget.kharj.price = int.parse(priceController.text);
                          widget.kharj.title = titleController.text;
                          widget.kharj.description = descriptionController.text;
                          String newDate;
                          if (dateType==1){ // Gregorian
                            newDate = '${dateController.text} ${widget.kharj.dateTime.toString().substring(11, 19)}';
                          }
                          else{ // Jalali
                            String temp = dateController.text;
                            int y = int.parse(temp.substring(0, 4));
                            int m = int.parse(temp.substring(5, 7));
                            int d = int.parse(temp.substring(8, 10));
                            Jalali jDate = Jalali(y, m, d);
                            Gregorian gDate = jDate.toGregorian();
                            int gy = gDate.year;
                            String gm = gDate.month.toString();
                            gm = gm.length>1?gm:'0$gm';
                            String gd = gDate.day.toString();
                            gd = gd.length>1?gd:'0$gd';
                            String gString = '$gy-$gm-$gd';
                            newDate = '$gString ${widget.kharj.dateTime.toString().substring(11, 19)}';
                          }
                          widget.kharj.dateTime = DateTime.parse(newDate);
                          widget.kharj.save();
                          Navigator.of(context).pop();
                        }
                        catch (e){
                          SnackBar errorSnackBar = const SnackBar(
                            backgroundColor: Colors.purple,
                            showCloseIcon: true,
                            content: Center(child: Text('تاریخ را به صورت صحیح وارد کنید')),
                            duration: Duration(seconds: 5),
                            elevation: 5,
                            padding: EdgeInsets.all(8),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                          FocusScope.of(context).requestFocus(dateFocusNode);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green.shade900)),
                      child: const ClipRRect(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12.0),
                          child: Text(
                            'تایید و ثبت',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void reset() {
    priceController.text = widget.kharj.price.toString();
    titleController.text = widget.kharj.title;
    descriptionController.text = widget.kharj.description;
    dateController.text = myJalaliMaker(widget.kharj.dateTime);
    FocusScope.of(context).requestFocus(priceFocusNode);
  }
}