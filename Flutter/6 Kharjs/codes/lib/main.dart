import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kharjs/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myfunctions.dart';
import 'mywidgets/alertwidget.dart';
import 'mywidgets/emptystate.dart';
import 'mywidgets/firsttimewidget.dart';
import 'mywidgets/kharjwidget.dart';
import 'mywidgets/kharjwidgetupdate.dart';

var now = DateTime.now();
late int
    dateType; // dateType=1 => Gregorian date format. dateType=2 => Jalali date format.
late bool
    firstTime; // firstTime = true => show Instructions. firstTime = false => show the program
late final SharedPreferences prefs;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(KharjAdapter());
  await Hive.openBox<Kharj>('kharjs');
  // Obtain shared preferences.
  prefs = await SharedPreferences.getInstance();
  dateType = prefs.getInt('dateType') ?? 1;
  firstTime = prefs.getBool('firstTime') ?? true;
  prefs.setBool('firstTime', false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kharjs',
      theme: ThemeData(
        dividerTheme: const DividerThemeData(
          color: Colors.orangeAccent,
          thickness: 0.6,
          space: 2,
          indent: 4,
          endIndent: 4,
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          primaryContainer: Colors.brown,
          background: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 28,
            color: Colors.white70,
          ),
          titleMedium: TextStyle(
            fontSize: 32,
            color: Colors.white70,
          ),
          displayLarge: TextStyle(
            fontSize: 32,
            color: Colors.white70,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var priceController = TextEditingController();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var startDateController = TextEditingController(
      text: myJalaliMaker(DateTime(now.year, now.month, now.day - 7)));
  var endDateController = TextEditingController(text: myJalaliMaker(now));
  var myFocusNode = FocusNode();
  Kharj kharj = Kharj();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    priceController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;
    // final double sHeight = MediaQuery.of(context).size.height; // استفاده نشده بود کامنتش کردم.
    final box = Hive.box<Kharj>('kharjs');

    return PageView(physics: const BouncingScrollPhysics(), children: [
      firstTime
          ? const FirstTimeWidget()
          : const KharjWidget(title: 'اضافه کردن هزینه جدید'),
      // KharjDetail(),
      Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.purple.shade400)),
                onPressed: () {
                  dateType = dateType == 1 ? 2 : 1;
                  prefs.setInt('dateType', dateType);
                  setState(() {
                    startDateController.text = myJalaliMaker(
                        DateTime(now.year, now.month, now.day - 7));
                    endDateController.text = myJalaliMaker(now);
                  });
                },
                child: Text(dateType == 1 ? 'میلادی' : 'شمسی'),
              ),
            ),
          ],
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
          title: const Text('کل هزینه ها'),
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
          child: ValueListenableBuilder<Box<Kharj>>(
            valueListenable: box.listenable(),
            builder: (BuildContext context, box, Widget? child) {
              var items = box.values.toList();
              items = box.values.where((kharj) {
                return isKharjInRange(kharj.dateTime, startDateController.text,
                    endDateController.text);
              }).toList();
              items.sort(
                (a, b) {
                  if (a.dateTime.year.compareTo(b.dateTime.year) == 0) {
                    if (a.dateTime.month.compareTo(b.dateTime.month) == 0) {
                      return a.dateTime.day.compareTo(b.dateTime.day);
                    }
                    return a.dateTime.month.compareTo(b.dateTime.month);
                  }
                  return a.dateTime.year.compareTo(b.dateTime.year);
                },
              );
              if (box.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final Kharj kharj = items[index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: InkWell(
                                  onLongPress: () {
                                    if (kharj.isReviewed == true) {
                                      box.deleteAt(index);
                                      // box.delete(key);
                                    } else {
                                      SnackBar errorSnackBar = const SnackBar(
                                        backgroundColor: Colors.purple,
                                        showCloseIcon: true,
                                        content: Center(
                                            child: Text(
                                          "برای پاک کردن دایمی یک خرج ابتدا باید تیک ثبت شدن آن را فعال کنید\n پس از فعال کردن تیک 'ثبت شد' با نگهداشتن انگشت خود روی یک خرج میتوانید آن را به طور دایم حذف کنید",
                                          textAlign: TextAlign.center,
                                        )),
                                        duration: Duration(seconds: 10),
                                        elevation: 5,
                                        padding: EdgeInsets.all(8),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(errorSnackBar);
                                    }
                                  },
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return KharjWidgetUpdate(
                                          title: 'جزییات هزینه',
                                          kharj: kharj,
                                        );
                                      },
                                    ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: sWidth / 5,
                                        child: Column(
                                          children: [
                                            Text(
                                              getNameOfWeekDayInJalali(
                                                  kharj.dateTime.weekday),
                                              style: TextStyle(
                                                fontSize: 12,
                                                decoration: kharj.isReviewed
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                decorationThickness: 2,
                                                decorationColor: Colors.white,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                            ),
                                            Text(
                                              myJalaliMaker(kharj.dateTime)
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                fontSize: 12,
                                                decoration: kharj.isReviewed
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                decorationThickness: 2,
                                                decorationColor: Colors.white,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                            ),
                                            Text(
                                              "${kharj.dateTime}"
                                                  .substring(11, 19),
                                              style: TextStyle(
                                                fontSize: 12,
                                                decoration: kharj.isReviewed
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                decorationThickness: 2,
                                                decorationColor: Colors.white,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            kharj.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              decoration: kharj.isReviewed
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              decorationThickness: 2,
                                              decorationColor: Colors.white,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          '${kharj.price} تومان',
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration: kharj.isReviewed
                                                ? TextDecoration.lineThrough
                                                : null,
                                            decorationThickness: 2,
                                            decorationColor: Colors.white,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Checkbox(
                                            value: kharj.isReviewed,
                                            onChanged: (value) {
                                              setState(() {
                                                kharj.isReviewed = value == true
                                                    ? true
                                                    : false;
                                                kharj.save();
                                              });
                                            },
                                            fillColor: MaterialStateProperty
                                                .resolveWith((states) {
                                              if (kharj.isReviewed) {
                                                return Colors.green;
                                              }
                                              return Colors.blue;
                                            }),
                                            activeColor: Colors.white,
                                            checkColor: Colors.orange,
                                          ),
                                          Text(
                                            kharj.isReviewed ? "ثبت شد" : "",
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              const Text(
                                "از:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: startDateController,
                                  cursorColor: Colors.blue,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.datetime,
                                  maxLength: 10,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                  ),
                                ),
                              ),
                              const Text(
                                "تا:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: endDateController,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                  maxLength: 10,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.green.shade900)),
                                  child: const Text(
                                    "نمایش",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const EmptyState();
              }
            },
          ),
        ),
      ),
      PageView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(color: Colors.green),
          Container(color: Colors.yellow),
          Container(color: Colors.purple),
          Container(
            color: Colors.blue,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showAlertDialog(context, box);
                },
                child: const Icon(
                  CupertinoIcons.trash_fill,
                  color: Colors.red,
                  size: 80,
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}