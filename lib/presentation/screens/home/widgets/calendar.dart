import 'package:flutter/material.dart';
import 'package:todoapp/blocs/bloc_exports.dart';
import 'package:todoapp/styles/app_decorations.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';
import 'package:todoapp/utils/data_util.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    dates[0]['isSelected'] = true;
    _setupScrollController();
  }

  final ScrollController _controller = ScrollController();
  void _setupScrollController() {
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      DateTime lastDate = dates[dates.length - 1]['date'];

      final List<Map> updatedList = List.generate(
          10,
          (index) => {
                'id': index,
                'date': lastDate.add(Duration(days: index + 1)),
                'isSelected': false
              });

      setState(() {
        dates.addAll(updatedList);
      });
    }
  }

  final DateTime now = DateTime.now();
  late List<Map> dates = List.generate(
      30,
      (index) => {
            'id': index,
            'date': DateTime(now.year, now.month, now.day)
                .add(Duration(days: index)),
            'isSelected': false
          });

  String currentDateTitle = DataUtil.getDataFormat(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentDateTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 80.0,
              child: _buildCalendarList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: _buildCalendarCard,
      separatorBuilder: _buildSeparatorBuilder,
      itemCount: dates.length,
      controller: _controller,
    );
  }

  Widget _buildCalendarCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentDateTitle = DataUtil.getDataFormat(dates[index]['date']);

          for (Map date in dates) {
            date['isSelected'] = false;
          }

          if (dates[index]['id'] == index) {
            dates[index]['isSelected'] = true;
          }

          BlocProvider.of<TaskBloc>(context)
              .add(SetTaskDate(date: dates[index]['date']));

          BlocProvider.of<TaskBloc>(context).add(const GetTasks());
        });
      },
      child: Container(
        width: 64.0,
        decoration:
            AppDecorations.calendarCard(dates[index]['isSelected'], context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DataUtil.getDayNum(dates[index]['date']),
              style: AppTextStyles.calendarCardNum(
                  dates[index]['isSelected'], context),
            ),
            Text(
              DataUtil.getDayText(dates[index]['date']),
              style: AppTextStyles.calendarCardText(
                  dates[index]['isSelected'], context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      width: 10.0,
    );
  }
}
