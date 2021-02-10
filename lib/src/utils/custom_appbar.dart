import 'package:doctor_booking_app/src/common/common_widgets.dart';
import 'package:doctor_booking_app/src/themes/styles.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BmdAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final IconData leading;
  final dynamic action;
  final Function onPressed;
  final Function onActionTapped;

  @override
  final Size preferredSize;

  // ignore: sort_constructors_first
  BmdAppBar(
      {@required this.title,
      @required this.leading,
      this.onPressed,
      this.onActionTapped,
      this.action})
      : preferredSize = Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    final _size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var _themeData = Theme.of(context);
    return Stack(children: <Widget>[
      ClipPath(
        // clipper: BezierClipper(altClip: true),
        child: Container(
          // color: Styles.RED,//Color.fromRGBO(255, 91, 53, 1),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   // colors: <Color>[
            //   //   // _themeData.primaryColor,
            //   //   // _themeData.primaryColor,
            //   //   // BmdColors.body
            //   // ],
            // ),
          ),
          height: preferredSize.height,
        ),
      ),
      Positioned(
        bottom: 125,
        left: -55,
        child: CommonWidgets.circularContainer(
            _size.width * .3, Colors.transparent,
            borderColor: BmdColors.lightGrey, borderWidth: 5),
      ),
      Positioned(
          bottom: 225,
          right: -50,
          child: CommonWidgets.circularContainer(
              _size.width * .4, BmdColors.lightGrey)),
      Padding(
        padding: EdgeInsets.only(top: 32, left: 4, right: 4, bottom: 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading != null
                    ? IconButton(
                        icon: Icon(leading, color: BmdColors.accent),
                        onPressed: onPressed,
                      )
                    : Icon(
                        leading,
                        color: BmdColors.lightGrey,
                      ),
                title is Widget
                    ? title
                    : SizedBox(
                        child: Text(
                          title,
                          style: textTheme.headline4
                              .copyWith(color: BmdColors.lightGrey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                        width: _size.width * 0.70)
              ],
            ),
            action != null
                ? action is Widget
                    ? action
                    : IconButton(
                        icon: Icon(action, color: BmdColors.lightGrey),
                        onPressed: onActionTapped,
                      )
                : Container(),
          ],
        ),
      )
    ]);
  }
}
