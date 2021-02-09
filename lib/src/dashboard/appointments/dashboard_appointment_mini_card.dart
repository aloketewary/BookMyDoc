import 'package:doctor_booking_app/src/common/common_widgets.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardAppointmentMiniCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accentColor = Theme.of(context).accentColor;
    // final ThemeProvider themeChange = Provider.of<ThemeProvider>(context);
    bool isDark = false; //themeChange.isDark(context);
    final _size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Container(
            height: 180,
            width: 140,
            margin: EdgeInsets.only(right: 10),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.lightDarkCard
                                : Colors.grey.shade200),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: -10,
                                right: -110,
                                child: CommonWidgets.circularContainer(
                                    240,
                                    isDark
                                        ? AppColors.darkerCard.withOpacity(0.18)
                                        : Colors.grey.shade300)),
                            Positioned(
                                top: -155,
                                right: -110,
                                child: CommonWidgets.circularContainer(
                                    _size.width * .6,
                                    isDark
                                        ? AppColors.darkerCard.withOpacity(0.35)
                                        : Colors.grey.shade500)),
                            Positioned(
                              bottom: -10,
                              right: -55,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: isDark
                                    ? AppColors.black.withOpacity(0.32)
                                    : AppColors.black.withOpacity(0.12),
                              ),
                            ),
                            // Positioned(
                            //     top: -180,
                            //     right: -30,
                            //     child: CommonWidgets.circularContainer(
                            //         _size.width * .7, Colors.transparent,
                            //         borderColor: isDark
                            //             ? Colors.black54
                            //             : Colors.white38)),
                            // Positioned(
                            //     top: -110,
                            //     right: -30,
                            //     child: CommonWidgets.circularContainer(
                            //         _size.width * .4, Colors.transparent,
                            //         borderColor: isDark
                            //             ? Colors.black54
                            //             : Colors.white60)),
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                // onTapCallback();
                              },
                              splashColor: accentColor.withOpacity(0.3),
                              enableFeedback: true,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: CircleAvatar(
                                            child: Text("C",
                                                style: textTheme.headline4
                                                    .copyWith(
                                                        color: Colors.white)),
                                            backgroundColor: accentColor,
                                            radius: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Arindam Test",
                                      style: textTheme.headline6.copyWith(
                                          color: accentColor.withOpacity(0.9),
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Test Address",
                                      style: textTheme.subtitle2.copyWith(
                                          color: accentColor.withOpacity(0.9),
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    RaisedButton(
                                      onPressed: () {},
                                      child: Text(
                                        "DELETE",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    )
                                    // CircularPercentIndicator(
                                    //   radius: 80.0,
                                    //   lineWidth: 8.0,
                                    //   percent: bloodRequest.completedUnits /
                                    //       (bloodRequest.requireUnits <
                                    //               bloodRequest.completedUnits
                                    //           ? bloodRequest.completedUnits
                                    //           : bloodRequest.requireUnits),
                                    //   circularStrokeCap:
                                    //       CircularStrokeCap.round,
                                    //   center: Image.asset(
                                    //     bloodRequest.completedUnits ==
                                    //             bloodRequest.requireUnits
                                    //         ? 'assets/img/healthcare-and-medical.png'
                                    //         : _sharedServices
                                    //             .mapDonationTypeDataWithImage(
                                    //                 bloodRequest.donationType),
                                    //     width: 45,
                                    //   ),
                                    //   progressColor: Colors.red,
                                    //   backgroundColor: isDark
                                    //       ? accentColor.withAlpha(90)
                                    //       : accentColor.withAlpha(90),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
