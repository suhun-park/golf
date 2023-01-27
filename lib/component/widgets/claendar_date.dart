import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/const/styles.dart';

class ClaendarDate extends StatelessWidget {
  const ClaendarDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
      onDateSelected: (date) => log(date.toString()),
      leftMargin: 10,
      monthColor: Colors.black.withOpacity(0.9),
      dayColor: Colors.black.withOpacity(0.6),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Color(Styles.appBarColor.value),
      dotsColor: Colors.black.withOpacity(0.6),
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'ko',
    );
  }
}
