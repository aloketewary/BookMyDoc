import 'package:doctor_booking_app/src/themes/styles.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardGlanceCard extends StatelessWidget {
  DashboardGlanceCard(
      {this.icon, this.titleText, this.subTitleText, this.onCardTap});

  final IconData icon;
  final String titleText;
  final String subTitleText;
  final Function onCardTap;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    final accentColor = Theme.of(context).accentColor;
    final primaryColor = Theme.of(context).primaryColor;
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 3,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Container(
                width: size.width / 2.2,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Styles.orange,
                      Styles.grey,
                    ],
                  ),
                  // color:
                  //     isDark ? AppColors.lightDarkCard : Colors.grey.shade200
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      size: 50,
                      color: primaryColor,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          titleText,
                          style: textTheme.headline3
                              .copyWith(color: Styles.nearlyWhite),
                        ),
                        Container(
                          width: size.width,
                          child: Text(
                            subTitleText,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline6
                                .copyWith(color: Styles.nearlyWhite),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ))),
    );
  }
}
