import 'package:bezier_chart/bezier_chart.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSlip extends StatefulWidget {
  @override
  _PaymentSlipState createState() => _PaymentSlipState();
}

class _PaymentSlipState extends State<PaymentSlip> {
  Color whiteColor = Colors.white70;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 720,
        height: 1280,
        allowFontScaling: false); //flutter_screenuitl >= 1.2
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: HEIGHT - 20.h),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: WIDTH,
                    height: HEIGHT / 2 - 200.h,
                    decoration: BoxDecoration(
                        color: Color(0xffAC3F21),
                        borderRadius: BorderRadius.circular(40.h)),
                    child: Container(
                      padding: EdgeInsets.all(50.h),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "\u20B9 ${5000}",
                                style: GoogleFonts.poppins(
                                  fontSize: 50.sp,
                                  color: Colors.white70,
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.applePay,
                                size: 80.h,
                                color: Colors.white70,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              WhiteTextWidget(text: "Balance"),
                              WhiteTextWidget(text: "Total Earning"),
                              WhiteTextWidget(text: "Saving")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Earnings",
                            style: GoogleFonts.poppins(
                                fontSize: 30.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "\u20B9 1235",
                          style: GoogleFonts.poppins(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: WIDTH,
                      height: HEIGHT / 2,
                      child: LineChartWidget(gradientColors: gradientColors))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    Key key,
    @required this.gradientColors,
  }) : super(key: key);

  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0x1337434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0x5568737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0x5567727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            if (value % 50 == 0) {
              return '${value.toInt()}';
            }
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 1200.h,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 300),
            FlSpot(2, 500),
            FlSpot(2.6, 200),
            FlSpot(4.9, 500),
            FlSpot(6.8, 310),
            FlSpot(8, 430),
            FlSpot(9.5, 300),
            FlSpot(11, 400),
          ],
          isCurved: true,
          colors: [Color(0xffF68A35)],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    ));
  }
}

class WhiteTextWidget extends StatelessWidget {
  const WhiteTextWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white60),
    );
  }
}
