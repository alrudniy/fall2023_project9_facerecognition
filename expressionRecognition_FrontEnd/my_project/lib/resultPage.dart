import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> analysisResult;
  final String imagePath;

  ResultPage({required this.analysisResult, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final emotions = analysisResult['emotion'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Result'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 30,
            child: Center(
              child: imagePath == null
                  ? Text('No image selected.')
                  : Image.file(File(imagePath)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: BarChart(
                BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text('Angry');
                              case 1:
                                return Text('Disgust');
                              case 2:
                                return Text('Fear');
                              case 3:
                                return Text('Happy');
                              case 4:
                                return Text('Sad');
                              case 5:
                                return Text('Surprise');
                              case 6:
                                return Text('Neutral');
                              default:
                                return Text('');
                            }
                          },
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            );
                            String text;
                            switch (value.toInt()) {
                              case 20:
                                text = '20';
                                break;
                              case 40:
                                text = '40';
                                break;
                              case 60:
                                text = '60';
                                break;
                              case 80:
                                text = '80';
                                break;
                              case 100:
                                text = '100';
                                break;
                              default:
                                return Container();
                            }
                            return Text(text,
                                style: style, textAlign: TextAlign.right);
                          },
                        ),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: false, reservedSize: 20)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.black12,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['angry'],
                            color: Colors.red,
                            width: 22,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['disgust'],
                            color: Colors.green,
                            width: 22,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['fear'],
                            color: Colors.blue,
                            width: 22,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['happy'],
                            color: Colors.yellow,
                            width: 22,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['sad'],
                            color: Colors.indigo,
                            width: 22,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['surprise'],
                            color: Colors.orange,
                            width: 22,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(
                            toY: emotions['neutral'],
                            color: Colors.grey,
                            width: 22,
                          )
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
