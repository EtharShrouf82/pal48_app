import 'package:flutter/material.dart';
import 'package:pal48/components/notification_card.dart';
import 'package:pal48/providers/notification_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الإشعارات",
          style: kPragraphTextStyle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ),
      body: SafeArea(
        child: notificationProvider.isLoading == false
            ? ListView.builder(
                itemCount: notificationProvider.notifications.length,
                itemBuilder: (context, index) => NotificationCard(
                  title: notificationProvider.notifications[index].title,
                  time: notificationProvider.notifications[index].time,
                  screen: notificationProvider.notifications[index].follow,
                  pageId: notificationProvider.notifications[index].pageId,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
      ),
    );
  }
}
