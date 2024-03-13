import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.pink.shade400,
        dividerTheme: DividerThemeData(
          color: surfaceColor,
          indent: 16,
          endIndent: 16,
        ),
        // textTheme: GoogleFonts.lalezarTextTheme(),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromARGB(255, 30, 30, 30),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: surfaceColor,
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          TextTheme(
            bodyLarge: TextStyle(
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
                // color: Colors.black87,
                fontSize: 14,
                color: Color.fromARGB(200, 255, 255, 255)),
            bodySmall: TextStyle(
              fontSize: 12,
            ),
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List frameWorkPathes = [
    'assets/images/frameworks/bootstrap.png',
    'assets/images/frameworks/django.png',
    'assets/images/frameworks/flutter.png',
    'assets/images/frameworks/vue.png',
    'assets/images/frameworks/laravel.png',
  ];
  List frameWorkTitles = [
    'Bootstrap',
    'Django',
    'Flutter',
    'Vue',
    'Laravel',
  ];
  SnackBar snackBar = SnackBar(
    backgroundColor: Colors.teal,
    showCloseIcon: true,
    content: Center(child: Text('Thanks for your comment')),
  );
  var changingIcon = CupertinoIcons.heart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poulstar Project'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.looks_one_rounded),
          ),
          Icon(Icons.looks_two_rounded),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      // child: Image.network(
                      //   "https://avatars.githubusercontent.com/u/61373450?s=200&v=4",
                      //   width: 120,
                      //   height: 120,
                      // )
                      child: Image.asset(
                        "assets/images/poulstar.png",
                        width: 120,
                        height: 120,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Poulstar Institute",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Programming & Soft Skills"),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              color: CupertinoColors.activeBlue,
                              // color: Theme.of(context).textTheme.bodyMedium!.color,
                              size: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Rash, Iran",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (changingIcon == CupertinoIcons.heart) {
                              changingIcon = CupertinoIcons.heart_fill;
                            } else {
                              changingIcon = CupertinoIcons.heart;
                            }
                          });
                        },
                        icon: Icon(
                          changingIcon,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      flex: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Text(
                "Poulstar is an institute founded on 2017.The CEO is Mehrgan Roohi."
                "This institute focuses on teaching different modern programming "
                "languages to children and teenagers. An important point that separates"
                " Poulstar from other institutes is that soft skills of "
                "children is as important as the programming itself for us.",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Programming Languages",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 13,
                  ),
                ],
              ),
            ),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  ProgrammingLanguageWidget(
                    name: "Python",
                    path: "assets/images/languages/py.png",
                    shadowColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        ProgrammingLanguageWidget.language = "Python";
                      });
                    },
                  ),
                  ProgrammingLanguageWidget(
                    name: "Scratch",
                    path: "assets/images/languages/scratch.png",
                    shadowColor: Colors.orange,
                    onTap: () {
                      setState(() {
                        ProgrammingLanguageWidget.language = "Scratch";
                      });
                    },
                  ),
                  ProgrammingLanguageWidget(
                    name: "dart",
                    path: "assets/images/languages/dart.png",
                    shadowColor: Colors.blue,
                    onTap: () {
                      setState(() {
                        ProgrammingLanguageWidget.language = "dart";
                      });
                    },
                  ),
                  ProgrammingLanguageWidget(
                    name: "MySql",
                    path: "assets/images/languages/mysql.png",
                    shadowColor: Colors.lightBlueAccent,
                    onTap: () {
                      setState(() {
                        ProgrammingLanguageWidget.language = "MySql";
                      });
                    },
                  ),
                  ProgrammingLanguageWidget(
                    name: "JavaScript",
                    path: "assets/images/languages/js.png",
                    shadowColor: Colors.yellowAccent,
                    onTap: () {
                      setState(() {
                        ProgrammingLanguageWidget.language = "JavaScript";
                      });
                    },
                  ),
                  ProgrammingLanguageWidget(
                    name: "php",
                    path: "assets/images/languages/php.png",
                    shadowColor: Colors.deepPurpleAccent,
                    onTap: () {
                      setState(() {
                        ProgrammingLanguageWidget.language = "php";
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Frameworks",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 13,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              height: 120,
              // width: double.infinity, // nazarim ham kar mikoneh.
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: frameWorkPathes.length,
                itemBuilder: (BuildContext context, int index) {
                  return FrameWorkWidget(
                      title: frameWorkTitles[index],
                      imagePath: frameWorkPathes[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(CupertinoIcons.at),
                      // icon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Write a comment!",
                      prefixIcon:
                          Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                      // Icon: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text(
                        "Send",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FrameWorkWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const FrameWorkWidget({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Column(
          children: [
            Container(width: 60, height: 60, child: Image.asset(imagePath)),
            SizedBox(
              height: 4,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class ProgrammingLanguageWidget extends StatelessWidget {
  final String name;
  final String path;
  final Color shadowColor;
  static String language = '';
  final Function() onTap;

  const ProgrammingLanguageWidget({
    super.key,
    required this.name,
    required this.path,
    required this.shadowColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: language == name
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    )
                  : null,
              child: Image.asset(
                path,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
