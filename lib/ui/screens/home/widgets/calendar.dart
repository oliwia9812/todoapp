import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';
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
    _setupScrollController();
    super.initState();
  }

  final ScrollController _controller = ScrollController();
  void _setupScrollController() {
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      DateTime lastDate = dates.last;
      List<DateTime> newList =
          List.generate(10, (index) => lastDate.add(Duration(days: index + 1)));

      setState(() {
        dates.addAll(newList);
      });
    }
  }

  List<DateTime> dates =
      List.generate(30, (index) => DateTime.now().add(Duration(days: index)));

  String currentDateTitle = DataUtil.getDataFormat(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentDateTitle,
            style: AppTextStyles.title(color: AppColors.white),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 80.0,
            child: _buildCalendarList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      itemBuilder: _buildCalendarCard,
      separatorBuilder: _buildSeparatorBuilder,
      itemCount: dates.length,
    );
  }

  Widget _buildCalendarCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentDateTitle = DataUtil.getDataFormat(dates[index]);
        });
      },
      child: Container(
        width: 64.0,
        decoration: AppDecorations.calendarCard(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DataUtil.getDayNum(dates[index]),
              style: AppTextStyles.calendarCardNum(),
            ),
            Text(
              DataUtil.getDayText(dates[index]),
              style: AppTextStyles.calendarCardText(),
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
