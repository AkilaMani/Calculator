import 'package:calculator/string.dart';
import 'package:calculator/values/app_colors.dart';
import 'package:calculator/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        title: const Text(Strings.appTitle),
        centerTitle: true,
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion,
                          style: TextStyle(
                              fontSize: fontSize, color: AppColors.white)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style:
                          TextStyle(fontSize: fontSize, color: AppColors.white),
                    ),
                  )
                ],
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        orientation == Orientation.portrait ? 4 : 10),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                        buttonTapped: () {
                          tempA = userAnswer;
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: AppColors.blue,
                        textColor: AppColors.white);
                  }

                  // Delete Button
                  else if (index == 1) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: AppColors.blue,
                        textColor: AppColors.white);
                  }

                  // Equal Button
                  else if (index == 19) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: AppColors.blue,
                        textColor: AppColors.white);
                  }

                  // ANS Button
                  else if (index == 18) {
                    return MyButton(
                        buttonTapped: () {
                          if ((userQuestion.length + userAnswer.length) > 17) {
                            var temp =
                                (userQuestion.length + userAnswer.length) - 17;
                            userQuestion += tempA;
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - temp);
                            });
                          } else {
                            setState(() {
                              userQuestion += tempA;
                            });
                          }
                        },
                        buttonText: buttons[index],
                        color: AppColors.primaryForegroundColor,
                        textColor: AppColors.white);
                  }

                  // Rest of the buttons
                  else {
                    return MyButton(
                        buttonTapped: () {
                          if (userQuestion.length >= 17) {
                            setState(() {
                              // ignore: deprecated_member_use
                              Scaffold.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      'Maximum number of digits (17) exceeded.')));
                            });
                          } else {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          }
                        },
                        buttonText: buttons[index],
                        color: AppColors.primaryForegroundColor,
                        textColor: AppColors.white);
                  }
                }),
          ],
        );
      }),
    );
  }


  bool isOperator(String x) {
    if (x == '%' || x == '÷' || x == '×' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('%', '*0.01');
    finalQuestion = finalQuestion.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
