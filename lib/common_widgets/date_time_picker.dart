import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home/job_entries/format.dart';
import 'package:time_tracker_flutter/common_widgets/input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    required Key key,
    required this.labelText,
    required this.selectedDate,
    required this.selectedTime,
    required this.onSelectedDate,
    required this.onSelectedTime,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onSelectedDate;
  final ValueChanged<TimeOfDay> onSelectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectedTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.titleMedium!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText,
            valueText: Format.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          flex: 4,
          child: InputDropdown(
            labelText: '',
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectTime(context),
          ),
        ),
      ],
    );
  }
}
