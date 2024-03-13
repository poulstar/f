import 'dart:math' as math;
import 'package:asmrdevs_weather_app/api/api.dart';
import 'package:asmrdevs_weather_app/widgets/custom_container.dart';
import 'package:asmrdevs_weather_app/widgets/date_widget.dart';
import 'package:asmrdevs_weather_app/widgets/hour_widget.dart';
import 'package:asmrdevs_weather_app/widgets/icons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use Class
  GetWeather weather = GetWeather();
  WeatherFilter weatherfilter = WeatherFilter();
  getDate getdate = getDate();
  bool isValidName = true;

  @override
  void initState() {
    super.initState();
    getWeather("London");
  }

  void getWeather(String city) async {
    var data = await weather.getForeCast(city);
    if (data == "404") {
      isValidName = false;
    } else {
      isValidName = true;
      weatherfilter = data;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xff11113A),
          body: Column(
            children: [
              AppBarCustom(sWidth),
              isValidName
                  ? Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            HeaderContainer(sWidth),
                            SizedBox(
                              width: sWidth,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          color: Colors.white10,
                                          offset: Offset(1, 1),
                                          blurRadius: 6,
                                        ),
                                      ],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffD2D1DB)),
                                ),
                              ),
                            ),
                            WeatherToday(sWidth),
                            const SizedBox(
                              height: 20,
                            ),
                            WeatherForecast(sWidth),
                          ],
                        ),
                      ),
                    )
                  : _404PageBuilder(sWidth, sHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget WeatherForecast(double sWidth){
    return CustomContainer(
      width: sWidth * 0.9,
      height: 265,
      border: 12,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder:
              (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 2.5),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      getdate.getDayForeCast(index - 1),
                      style: const TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            offset: Offset(2, 2),
                            blurRadius: 6,
                          ),
                        ],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffD2D1DB),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, right: 4),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: SvgPicture.asset(
                        "assets/images/rain-drop.svg",
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0),
                      child: Text(
                        "${weatherfilter.forecast["day-$index"]["daily_chance_of_rain"]} %",
                        style: const TextStyle(
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffD2D1DB),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20),
                    child: SizedBox(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 6.0),
                        child: Image.asset(
                          getIcons().getImageID(
                              weatherfilter.forecast[
                              "day-$index"]
                              ["condition-code"],
                              1),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${weatherfilter.forecast["day-$index"]["avgtemp_c"]} ",
                            style: TextStyle(
                              shadows: const [
                                Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 6,
                                ),
                              ],
                              fontSize: 14,
                              fontWeight:
                              FontWeight.bold,
                              color: const Color(
                                  0xffFEFEFE)
                                  .withOpacity(0.5),
                            ),
                          ),
                          Text(
                            "°C",
                            style: TextStyle(
                              shadows: const [
                                Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 6,
                                ),
                              ],
                              fontSize: 14,
                              fontWeight:
                              FontWeight.bold,
                              color: const Color(
                                  0xffFFA500)
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget WeatherToday(double sWidth){
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(
        width: sWidth,
        height: 125,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount:
          weatherfilter.hour_forecast[0].length,
          itemBuilder:
              (BuildContext context, int index) {
            return Padding(
              padding:
              const EdgeInsets.only(right: 2.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6.0),
                    child: Text(
                      CreateHour().Hour(
                          index,
                          weatherfilter.hour_forecast[0]
                          [index]["is_day"]),
                      style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.white10,
                              offset: Offset(1, 1),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffD2D1DB)
                              .withOpacity(0.5)),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 8),
                      child: Image.asset(
                        getIcons().getImageID(
                          weatherfilter.hour_forecast[0]
                          [index]["condition"]
                          ["code"],
                          weatherfilter.hour_forecast[0]
                          [index]["is_day"],
                        ),
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "${weatherfilter.hour_forecast[0][index]["temp_c"]} ",
                          style: TextStyle(
                            shadows: const [
                              Shadow(
                                color: Colors.white10,
                                offset: Offset(1, 1),
                                blurRadius: 6,
                              ),
                            ],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:
                            const Color(0xffFEFEFE)
                                .withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "°C",
                          style: TextStyle(
                            shadows: const [
                              Shadow(
                                color: Colors.white10,
                                offset: Offset(1, 1),
                                blurRadius: 6,
                              ),
                            ],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:
                            const Color(0xffFFA500)
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 13,
                          height: 13,
                          child: SvgPicture.asset(
                            "assets/images/rain-drop.svg",
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(
                              left: 6.0),
                          child: Text(
                            "${weatherfilter.hour_forecast[0][index]["chance_of_rain"]} %",
                            style: TextStyle(
                                shadows: const [
                                  Shadow(
                                    color:
                                    Colors.white10,
                                    offset:
                                    Offset(1, 1),
                                    blurRadius: 6,
                                  ),
                                ],
                                fontSize: 12,
                                fontWeight:
                                FontWeight.bold,
                                color: const Color(
                                    0xffD2D1DB)
                                    .withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget HeaderContainer(double sWidth){
    return CustomContainer(
      width: sWidth,
      height: 210,
      border: 0,
      child: Row(
        children: [
          SizedBox(
            width: sWidth * 0.5,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 20),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getdate.getDayShort(0)},${getdate.getDayNum()} ${getdate.getMonth()} ",
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffD2D1DB)
                              .withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "${weatherfilter.cityname} - ${weatherfilter.country} ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffD2D1DB)
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        "${weatherfilter.current["temp_c"]} ",
                        style: const TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                            ],
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFEFEFE)),
                      ),
                      const Text(
                        "°C",
                        style: TextStyle(
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFFA500),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationZ(
                              3.1415926535897932 / 2),
                          child: SvgPicture.asset(
                            "assets/images/arrow.svg",
                            color:
                            const Color(0xff7D7C94),
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4),
                        child: Text(
                          weatherfilter
                              .forecast["day-0"]
                          ["mintemp_c"]
                              .toString(),
                          style: TextStyle(
                            shadows: const [
                              Shadow(
                                color: Colors.black38,
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                            ],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color:
                            const Color(0xffD2D1DB)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0),
                        child: Text(
                          "°C",
                          style: TextStyle(
                            shadows: const [
                              Shadow(
                                color: Colors.black38,
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                            ],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color:
                            const Color(0xffFFA500)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationZ(
                              math.pi * 1.5),
                          child: SvgPicture.asset(
                            "assets/images/arrow.svg",
                            color:
                            const Color(0xff7D7C94),
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4),
                        child: Text(
                          weatherfilter
                              .forecast["day-0"]
                          ["maxtemp_c"]
                              .toString(),
                          style: TextStyle(
                            shadows: const [
                              Shadow(
                                color: Colors.black38,
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                            ],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color:
                            const Color(0xffD2D1DB)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                      Text(
                        "°C",
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffFFA500)
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30),
                  child: Text(
                    "${weatherfilter.current["condition-text"]} ",
                    style: TextStyle(
                        shadows: const [
                          Shadow(
                            color: Colors.black38,
                            offset: Offset(2, 2),
                            blurRadius: 6,
                          ),
                        ],
                        fontSize: weatherfilter.current["condition-text"].length > 16 ? 16 : 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffFEFEFE)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        "Feelings like ",
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffFEFEFE)
                              .withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "${weatherfilter.current["feelslike_c"]} ",
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffFEFEFE)
                              .withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "°C",
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffFFA500)
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 20.0),
              child: Image.asset(
                getIcons().getImageID(
                    weatherfilter
                        .current["condition-code"],
                    weatherfilter.current["is_day"]),
                width: 128,
                height: 128,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget AppBarCustom(double sWidth){
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: CustomContainer(
              height: 50,
              width: 1,
              border: 25,
              child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    getWeather(value);
                    FocusScope.of(context).unfocus();
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffC0BFCB),
                    fontSize: sWidth * 0.05,
                    shadows: const [
                      Shadow(
                        color: Color(0xff1D1D44),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: "Search Here !",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffC0BFCB).withOpacity(0.4),
                      fontSize: sWidth * 0.05,
                      shadows: const [
                        Shadow(
                          color: Color(0xff1D1D44),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  cursorColor: Colors.white70,
                  cursorWidth: 1.5),
            ),
          ),
          GestureDetector(
            onTap: () {
              getWeather(controller.text);
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CustomContainer(
                width: 50,
                height: 50,
                border: 25,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 12.0, left: 10, bottom: 4),
                  child: SvgPicture.asset("assets/images/search.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget _404PageBuilder(double sWidth, double sHeight) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: sWidth,
          height: sHeight * 0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Image.asset("assets/images/404-not-found.png"),
          ),
        ),
      ),
    );
  }


}


