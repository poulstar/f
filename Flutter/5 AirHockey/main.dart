import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Hockey Mohammad Pourmohammadi Fallah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dividerColor: Colors.white,
        dividerTheme: const DividerThemeData(space: 1),
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
  // player 1 & 2 attributes
  final playerSize = 45.0;
  late final playerRadius = playerSize / 2; //اگه late رو نذاریم قابل دسترسی نیست اینجا
  final player1 = "red";
  final player2 = "blue";
  final player1Color = Colors.red;
  final player2Color = Colors.blue;
  int player1Score = 0;
  int player2Score = 0;
  late double player1Left;
  late double player2Left;
  late double player1Top;
  late double player2Top;
  late double player1CenterX; // برای محاسبات ریاضی استفاده شده
  late double player2CenterX; // برای محاسبات ریاضی استفاده شده
  late double player1CenterY; // برای محاسبات ریاضی استفاده شده
  late double player2CenterY; // برای محاسبات ریاضی استفاده شده
  double player1ShotX = 0.0; // برای محاسبات ریاضی استفاده شده
  double player2ShotX = 0.0; // برای محاسبات ریاضی استفاده شده

  // ball attributes
  final ballSize = 45.0;
  late final ballRadius = ballSize / 2; //اگه late رو نذاریم قابل دسترسی نیست اینجا
  final ballColor = Colors.white;
  late double ballLeft;
  late double ballTop;
  late double ballCenterX; // برای محاسبات ریاضی استفاده شده
  late double ballCenterY; // برای محاسبات ریاضی استفاده شده
  late double xSpeed; // سرعت افقی حرکت توپ در بازی
  late double ySpeed; // سرعت عمودی حرکت توپ در بازی

  // table attributes
  late final double tableHeight; // ارتفاع میز بازی
  late final double tableWidth; // پهنای میز بازی

  // Start text attributes
  String textStart = 'Tap to start!';
  final textStartHeight = 120.0;
  final textStartWidth = 480.0;
  double textStartFontSize = 30.0;
  late final double textStartTop;
  late final double textStartLeft;

  // global attributes
  late String turn; // جهت تعیین نوبت بازی
  bool gameIsStarted = false;
  bool gameIsFinished = false;
  bool showStartText = true;
  late double distanceBall2P1; // برای محاسبات ریاضی
  late double distanceBall2P2; // برای محاسبات ریاضی
  final int gameEndsAt = 10; // پایان بازی

  // تابعی جهت گرفتن فاصله توپ از بازیکن ها. لازم نیست به بچه ها گفته بشه این ۳ خط. همین طوری بهشون بدیم.
  double fisaghores(double a, double b){
    return sqrt(pow(a, 2).toDouble() + pow(b, 2).toDouble());
  }

  void nextRound(String player) {
    player == player1 ? player1Score++ : player2Score++;
    turn = player == player1 ? player2 : player1;
    xSpeed = 0;
    ySpeed = 0;
    showStartText = true;
    if (player1Score == gameEndsAt) {
      textStart = "$player1 Wins";
      textStartFontSize *= 2;
      turn = player1;
      gameIsFinished = true;
    } else if (player2Score == gameEndsAt) {
      textStart = "$player2 Wins";
      textStartFontSize *= 2;
      turn = player2;
      gameIsFinished = true;
    }
    ballLeft = (tableWidth / 2) - ballRadius;
    ballTop = (tableHeight / 2) - ballRadius;
  }

  // تابعی جهت محاسبه برخورد توپ به بازیکن. لازم نیست به بچه ها گفته بشه.
  void doTheMathWork() {
    player1CenterX = player1Left + playerRadius;
    player1CenterY = player1Top + playerRadius;
    player2CenterX = player2Left + playerRadius;
    player2CenterY = player2Top + playerRadius;
    ballCenterX = ballLeft + ballRadius;
    ballCenterY = ballTop + ballRadius;
    distanceBall2P1 = fisaghores(ballCenterX - player1CenterX, ballCenterY - player1CenterY);
    distanceBall2P2 = fisaghores(ballCenterX - player2CenterX, ballCenterY - player2CenterY);

    // Player1 (top player) calculations
    if (distanceBall2P1 <= playerRadius + ballRadius) {
      xSpeed = (ballCenterX - player1CenterX) / (ballCenterY - player1CenterY);
      if (player1ShotX != 0) {
        xSpeed *= (1+player1ShotX);
      }
      xSpeed = xSpeed > 10 ? 10 : xSpeed;
      ySpeed = 1 / xSpeed.abs();
      ySpeed = ySpeed > 5 ? 5 : ySpeed;
    }

    // Player2 (bottom player) calculations
    else if (distanceBall2P2 <= playerRadius + ballRadius) {
      xSpeed = -(ballCenterX - player2CenterX) / (ballCenterY - player2CenterY);
      if (player2ShotX != 0) {
        xSpeed *= (1+player2ShotX);
      }
      xSpeed = xSpeed < -10 ? -10 : xSpeed;
      ySpeed = -1 / xSpeed.abs();
      ySpeed = ySpeed < (-5) ? (-5) : ySpeed;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    double sWidth = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;

    // این ها رو نمیشد در initstate گذاشت. چون initstate در هر بار build صدا زده میشه و نمیشد مهره ها رو حرکت داد. به خاطر همین از این کلک استفاده شد.
    if (!gameIsStarted) {
      tableWidth = sWidth - playerSize;
      tableHeight = sHeight - 4 * playerSize;
      player1Left = tableWidth / 2 - playerRadius;
      player1Top = 0;
      player2Left = tableWidth / 2 - playerRadius;
      player2Top = tableHeight - playerSize;
      textStartLeft = tableWidth / 2 - textStartWidth / 2;
      textStartTop = tableHeight / 2 - textStartHeight / 2;
      ballLeft = tableWidth / 2 - ballRadius;
      ballTop = tableHeight / 2 - ballRadius;
      turn = Random().nextBool()?player1:player2;
      gameIsStarted = true;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            color: Colors.green,
            width: tableWidth,
            height: tableHeight,
            child: Stack(
              children: [
                // میز
                Positioned(
                  child: Column(
                    children: [
                      SizedBox(
                        height: playerSize,
                      ),
                      const Divider(),
                      const Expanded(child: SizedBox()),
                      const Divider(),
                      const Expanded(child: SizedBox()),
                      const Divider(),
                      SizedBox(
                        height: playerSize,
                      ),
                    ],
                  ),
                ),

                // بازیکن بالایی
                !gameIsFinished
                    ? Positioned(
                        left: player1Left,
                        top: player1Top,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            player1Left += details.delta.dx;
                            player1Left = player1Left > 0 ? player1Left : 0;
                            player1Left =
                                player1Left < (tableWidth - playerSize)
                                    ? player1Left
                                    : (tableWidth - playerSize);
                            setState(() {});
                            player1ShotX = details.delta.dx;
                          },
                          onHorizontalDragEnd: (details) {
                            player1ShotX = 0;
                          },
                          child: PlayerWidget(
                              playerSize: playerSize,
                              playerColor: player1Color),
                        ),
                      )
                    : const SizedBox(),

                // بازیکن پایینی
                !gameIsFinished
                    ? Positioned(
                        left: player2Left,
                        top: player2Top,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            player2Left += details.delta.dx;
                            player2Left = player2Left > 0 ? player2Left : 0;
                            player2Left =
                                player2Left < (tableWidth - playerSize)
                                    ? player2Left
                                    : (tableWidth - playerSize);
                            setState(() {});
                            player2ShotX = details.delta.dx;
                          },
                          onHorizontalDragEnd: (details) {
                            player2ShotX = 0;
                          },
                          child: PlayerWidget(
                              playerSize: playerSize,
                              playerColor: player2Color),
                        ),
                      )
                    : const SizedBox(),

                // توپ
                !gameIsFinished
                    ? Positioned(
                        left: ballLeft,
                        top: ballTop,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(ballRadius),
                          child: Container(
                            width: ballSize,
                            height: ballSize,
                            color: ballColor,
                            child: Visibility(
                              visible: showStartText,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RotatedBox(
                                    quarterTurns: 2,
                                    child: Text(
                                      "You: $player1Score",
                                      style: TextStyle(
                                        fontSize: ballSize / 4,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "You: $player2Score",
                                    style: TextStyle(
                                      fontSize: ballSize / 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),

                // نوشته ای که روش میزنیم تا شروع شه.
                Positioned(
                  width: textStartWidth,
                  height: textStartHeight,
                  left: textStartLeft,
                  top: textStartTop,
                  child: Center(
                    child: Visibility(
                      visible: showStartText,
                      child: TextButton(
                        child: RotatedBox(
                          quarterTurns: turn == player1 ? 2 : 0,
                          child: Text(
                            textStart,
                            style: TextStyle(
                                fontSize: textStartFontSize,
                                color: turn == player1
                                    ? player1Color
                                    : player2Color),
                          ),
                        ),
                        onPressed: () async {
                          if (gameIsFinished) {
                            return;
                          }
                          // xSpeed = Random().nextBool() ? 2.0 : -2.0 ;  // simpler version
                          // ySpeed = turn == player1 ? 1.0 : -1.0 ;  // simpler version
                          xSpeed = Random().nextBool()
                              ? (Random().nextInt(3) + 1).toDouble()
                              : -(Random().nextInt(3) + 1).toDouble();
                          ySpeed = turn == player1
                              ? (Random().nextInt(2) + 1).toDouble()
                              : -(Random().nextInt(2) + 1).toDouble();
                          showStartText = false;
                          do {
                            ballLeft += xSpeed;
                            ballTop += ySpeed;
                            if (ballLeft > tableWidth - ballSize) {
                              // xSpeed *= -1; // this version has bug and sometimes the ball stucks in the right wall
                              xSpeed = (-1) * (xSpeed.abs());
                            } else if (ballLeft <= 0) {
                              // xSpeed *= -1; // this version has bug and sometimes the ball stucks in the left wall
                              xSpeed = xSpeed.abs();
                            }
                            if (ballTop > tableHeight - ballSize / 3) {
                              nextRound(player1);
                              break;
                            } else if (ballTop <= 0 - ballSize * 2 / 3) {
                              nextRound(player2);
                              break;
                            }
                            doTheMathWork();
                            await Future.delayed(
                                const Duration(milliseconds: 1));
                            setState(() {});
                          } while (true);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({
    super.key,
    required this.playerSize,
    required this.playerColor,
  });

  final double playerSize;
  final MaterialColor playerColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(playerSize / 2),
      child: Container(
        width: playerSize,
        height: playerSize,
        color: playerColor,
      ),
    );
  }
}
