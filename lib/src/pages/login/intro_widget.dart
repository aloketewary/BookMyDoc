import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {Key key,
      @required this.screenWidth,
      @required this.screenHeight,
      this.image,
      this.type,
      this.startGradientColor,
      this.endGradientColor,
      this.subText,
      this.icon})
      : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final image;
  final type;
  final Color startGradientColor;
  final Color endGradientColor;
  final String subText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    final linearGradient = LinearGradient(
      colors: <Color>[startGradientColor, endGradientColor],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: screenWidth * 0.6,
      padding: EdgeInsets.only(top: 25),
      // decoration: BoxDecoration(color: isDark ? Colors.black : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 10, 100),
            child: Center(
              child: Image.asset(
                image,
                width: screenWidth,
                height: screenHeight * 0.4,
                fit: BoxFit.cover,
              ),
//           child: Icon(
//             icon,
//             size: screenWidth,
//           ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Opacity(
                  opacity: isDark ? 0.30 : 0.15,
                  child: Container(
                    height: screenHeight * 0.15,
                    child: Text(
                      type.toString().toUpperCase(),
                      style: textTheme.headline1.copyWith(
                          // fontSize: 100.0,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 15,
                  child: Text(
                    type.toString().toUpperCase(),
                    style: textTheme.headline2.copyWith(
                        // fontSize: 62.0,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()..shader = linearGradient),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              subText,
              style: textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                  letterSpacing: 2.0),
            ),
          )
        ],
      ),
    );
  }

  TextStyle buildTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w900,
      height: 0.5,
    );
  }
}
