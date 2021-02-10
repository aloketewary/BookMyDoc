/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:doctor_booking_app/src/pages/dashboard/chart/time_series.dart';
import 'package:flutter/material.dart';

class TimeSeriesBar extends StatelessWidget {


  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  // factory TimeSeriesBar.withSampleData() {
  //   return TimeSeriesBar(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  final List<charts.Series<TimeSeriesSales, String>> seriesList;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
    );
  }

}
