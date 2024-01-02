import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:flutter_timeline_calendar/timeline/provider/instance_provider.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';
import 'package:pal48/models/event_model.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late CalendarDateTime selectedDateTime;
  late DateTime? weekStart;
  late DateTime? weekEnd;
  @override
  void initState() {
    super.initState();
    TimelineCalendar.calendarProvider = createInstance();
    selectedDateTime = TimelineCalendar.calendarProvider.getDateTime();
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).eventsDates,
          share: '${Api.url}/app',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _timelineCalendar(articleProvider),
          const SizedBox(
            height: defaultPadding,
          ),
          _getData(articleProvider),
        ],
      ),
    );
  }

  _getData(ArticleProvider articleProvider) {
    return Expanded(
      child: articleProvider.isDataLoaded
          ? const Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : articleProvider.eventsModel.isNotEmpty
              ? AnimationLimiter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: articleProvider.eventsModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.02),
                                    textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .fontSize,
                                    ),
                                  ),
                                  onPressed: () {
                                    articleProvider.getComments(
                                      articleProvider.eventsModel[index].id,
                                    );
                                    Navigator.pushNamed(context, '/details',
                                        arguments: {
                                          'id': articleProvider
                                              .eventsModel[index].id,
                                          'img': articleProvider
                                              .eventsModel[index].img,
                                          'images': articleProvider
                                              .eventsModel[index].images,
                                          'attachments': articleProvider
                                              .eventsModel[index].attachments,
                                          'desc': articleProvider
                                              .eventsModel[index].description,
                                          'title': articleProvider
                                              .eventsModel[index].title,
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getTitle(
                                          articleProvider.eventsModel[index],
                                        ),
                                        style: kSubHeadTextStyle.copyWith(
                                          fontFamily: 'DINN',
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        "assets/svg/Arrow - Left.svg",
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).iconTheme.color!,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : Center(
                  child: Text(translation(context).noEvent),
                ),
    );
  }

  getTitle(EventModel index) {
    var title = '';
    if (index.type == 5) {
      title = ' ${translation(context).displacement} ${index.title}';
    } else {
      title = index.title;
    }
    return title;
  }

  _timelineCalendar(ArticleProvider articleProvider) {
    return TimelineCalendar(
      calendarType: CalendarType.GREGORIAN,
      calendarLanguage: "en",
      calendarOptions: CalendarOptions(
        viewType: ViewType.DAILY,
        toggleViewType: true,
        headerMonthElevation: 10,
        headerMonthShadowColor: Colors.black26,
        headerMonthBackColor: Colors.transparent,
      ),
      dayOptions: DayOptions(
        compactMode: true,
        dayFontSize: 14.0,
        disableFadeEffect: true,
        weekDaySelectedColor: const Color(0xff3AC3E2),
        differentStyleForToday: true,
        todayBackgroundColor: Colors.black,
        selectedBackgroundColor: const Color(0xff3AC3E2),
        todayTextColor: Colors.white,
      ),
      headerOptions: HeaderOptions(
        weekDayStringType: WeekDayStringTypes.SHORT,
        monthStringType: MonthStringTypes.FULL,
        backgroundColor: primaryColor,
        headerTextSize: 14,
        headerTextColor: whiteColor,
        calendarIconColor: whiteColor,
        navigationColor: whiteColor,
        resetDateColor: whiteColor,
      ),
      onChangeDateTime: (dateTime) {
        selectedDateTime = dateTime;
        articleProvider.fetchEvents(dateTime.month, dateTime.day);
      },
      onDateTimeReset: (resetDateTime) {
        selectedDateTime = resetDateTime;
      },
      onMonthChanged: (monthDateTime) {
        selectedDateTime = monthDateTime;
      },
      onYearChanged: (yearDateTime) {
        selectedDateTime = yearDateTime;
      },
      dateTime: selectedDateTime,
    );
  }
}
