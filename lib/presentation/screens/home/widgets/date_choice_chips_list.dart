import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/blocs/bloc_exports.dart';
import 'package:todoapp/presentation/screens/home/widgets/date_choice_chip.dart';
import 'package:todoapp/styles/app_icons.dart';
import 'dart:io' show Platform;

class DateChoiceChipsList extends StatefulWidget {
  const DateChoiceChipsList({super.key});

  @override
  State<DateChoiceChipsList> createState() => _DateChoiceChipsListState();
}

class _DateChoiceChipsListState extends State<DateChoiceChipsList> {
  int? _value = 0;
  DateTime selectedDate = DateTime.now();

  final List<CustomDateChoiceChip> dateOptions = const [
    CustomDateChoiceChip(
      title: 'Today',
      icon: AppIcons.today,
    ),
    CustomDateChoiceChip(
      title: 'Tomorrow',
      icon: AppIcons.nextDay,
    ),
    CustomDateChoiceChip(
      icon: AppIcons.calendar,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(dateOptions.length, (index) {
        final listItem = dateOptions[index];
        return CustomDateChoiceChip(
          title: listItem.title,
          icon: listItem.icon,
          selected: _value == index,
          onSelected: (selected) {
            setState(() {
              _value = selected ? index : _value;

              switch (index) {
                case 0:
                  _setTodayDate();
                  break;
                case 1:
                  _setTommorowDate();
                  break;
                case 2:
                  if (Platform.isAndroid) {
                    _showAndroidCalendar();
                  } else if (Platform.isIOS) {}
                  _showIOSCalendar();
                  break;
                default:
              }
            });
          },
        );
      }).toList(),
    );
  }

  void _setTodayDate() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    BlocProvider.of<TaskBloc>(context).add(SetTaskDate(date: today));
  }

  void _setTommorowDate() {
    DateTime now = DateTime.now();
    final DateTime tommorow =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    BlocProvider.of<TaskBloc>(context).add(SetTaskDate(date: tommorow));
  }

  void _setSelectedByUserDate(DateTime selectedDate) {
    final DateTime selectedByUserDate = selectedDate;

    BlocProvider.of<TaskBloc>(context)
        .add(SetTaskDate(date: selectedByUserDate));
  }

  Future<void> _showAndroidCalendar() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        _setSelectedByUserDate(pickedDate);
      });
    }
  }

  Future<DateTime?> _showIOSCalendar() {
    return showCupertinoModalPopup(
      context: context,
      builder: ((context) {
        return Container(
          height: 300.0,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate,
            minimumDate: selectedDate,
            maximumYear: 2025,
            onDateTimeChanged: (value) {
              _setSelectedByUserDate(value);
            },
          ),
        );
      }),
    );
  }
}
